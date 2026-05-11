-- DeliverGuard validation landing page — Supabase initialization
-- Project: otiwvsflpcambhoqkqfw  (https://supabase.com/dashboard/project/otiwvsflpcambhoqkqfw/sql/new)
--
-- Run this ONCE in the Supabase SQL editor (or via `supabase db execute --project-ref otiwvsflpcambhoqkqfw < supabase-init.sql`).
-- Designed so the public anon key can: read the founding-spots config row, INSERT page-view rows,
-- INSERT email reminders, and read aggregate counts — without exposing reminder emails publicly.
-- This directly addresses the ReportPilot failure mode (anon reads returned 403 the whole window).

-- ───────────────────────────── config (founding-spots counter) ─────────────────────────────
create table if not exists public.config (
  key   text primary key,
  value text not null,
  updated_at timestamptz not null default now()
);

insert into public.config (key, value)
values ('deliverguard_founding_spots_remaining', '50')
on conflict (key) do nothing;

alter table public.config enable row level security;
drop policy if exists "config anon read" on public.config;
create policy "config anon read" on public.config
  for select to anon using (true);
-- (No anon UPDATE policy: the counter is decremented by the Stripe webhook / a human using the service-role key.)

-- ───────────────────────────── deliverguard_analytics (page-view + CTA telemetry) ─────────────────────────────
create table if not exists public.deliverguard_analytics (
  id         bigint generated always as identity primary key,
  event      text not null,                 -- 'pageview' | 'cta_click'
  path       text,
  referrer   text,
  user_agent text,
  created_at timestamptz not null default now()
);

alter table public.deliverguard_analytics enable row level security;
drop policy if exists "analytics anon insert" on public.deliverguard_analytics;
create policy "analytics anon insert" on public.deliverguard_analytics
  for insert to anon with check (event in ('pageview','cta_click'));
drop policy if exists "analytics anon read" on public.deliverguard_analytics;
create policy "analytics anon read" on public.deliverguard_analytics
  for select to anon using (true);
-- ^ Page-view telemetry must be readable by the Validator. These rows hold no PII (no email, no IP).

-- ───────────────────────────── deliverguard_signups (optional launch-day reminders) ─────────────────────────────
create table if not exists public.deliverguard_signups (
  id         bigint generated always as identity primary key,
  email      text not null,
  product    text not null default 'deliverguard',
  source     text,
  created_at timestamptz not null default now()
);

alter table public.deliverguard_signups enable row level security;
drop policy if exists "signups anon insert" on public.deliverguard_signups;
create policy "signups anon insert" on public.deliverguard_signups
  for insert to anon with check (product = 'deliverguard');
-- Intentionally NO anon SELECT policy on this table — emails stay private.
-- The Validator reads the COUNT via the SECURITY DEFINER function below.

create or replace function public.deliverguard_signup_count()
returns bigint
language sql
security definer
set search_path = public
as $$ select count(*) from public.deliverguard_signups $$;

grant execute on function public.deliverguard_signup_count() to anon;

-- ───────────────────────────── Validator read recipes (using the ANON key) ─────────────────────────────
-- Founding spots remaining:
--   GET {SUPABASE_URL}/rest/v1/config?select=value&key=eq.deliverguard_founding_spots_remaining
-- Page views (count):
--   GET {SUPABASE_URL}/rest/v1/deliverguard_analytics?select=*&event=eq.pageview   (use Prefer: count=exact + Range: 0-0 for just the count)
-- CTA clicks (count):
--   GET {SUPABASE_URL}/rest/v1/deliverguard_analytics?select=*&event=eq.cta_click
-- Email reminders (count only — emails not exposed):
--   POST {SUPABASE_URL}/rest/v1/rpc/deliverguard_signup_count
-- All requests need headers:  apikey: {SUPABASE_ANON_KEY}   Authorization: Bearer {SUPABASE_ANON_KEY}
