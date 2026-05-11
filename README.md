# DeliverGuard — Pre-Sell Validation Landing Page

Static, self-contained landing page used to validate demand for **DeliverGuard** — a tool that lets freelancers lock final deliverables behind a Stripe payment link (client previews the work; download unlocks the instant payment confirms).

- **Live (GitHub Pages):** https://erik-capital-ready-advisors.github.io/deliverguard-landing/
- **Stack:** single `index.html` + Tailwind CDN + Inter (Google Fonts). No build step.
- **CTAs:** Stripe Payment Links — `$9` per-delivery and `$19/mo` founding Pro (metadata `product=deliverguard`).
- **Telemetry / counter:** optional Supabase backend (`config`, `deliverguard_analytics`, `deliverguard_signups`). Run `supabase-init.sql` once; the page degrades gracefully if it's not set up.

## Files
| File | Purpose |
|---|---|
| `index.html` | The page. Verbatim copy from `pipeline/validated/deliverguard-landing-page-copy.md`. |
| `og-image.html` | Source for the social-share image. |
| `og-image.png` | 1200×628 rendered OG image (referenced in `<head>`). |
| `supabase-init.sql` | One-shot SQL: founding-spots counter + analytics + signups, with anon-readable policies. |
| `vercel.json` / `package.json` | Optional Vercel deploy (`vercel --prod --yes`) if you prefer a Vercel URL. |

## Deploy notes
GitHub Pages serves this repo as-is (a `.nojekyll` file disables Jekyll processing). To deploy elsewhere, just upload the directory — there is nothing to build.
