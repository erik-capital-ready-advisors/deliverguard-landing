# Design Tokens — DeliverGuard Validation Landing Page

*Issued by Designer Agent — 2026-05-11. Source brief: `pipeline/validated/deliverguard-designer-brief.md`*

DeliverGuard is a freelancer payment-gating tool. Category leans Productivity/Tools, but the brief's explicit colour direction (deep teal + warm amber) overrides the default palette table. Teal reads "trust / secure", amber drives the CTA contrast.

## Color System
| Token | Hex | Usage |
|---|---|---|
| `primary` | `#0d5c63` | Deep teal. Headlines accents, section eyebrows, How-It-Works step numbers, Pro pricing card border + badge, footer SEO text accent |
| `primary-dark` | `#0a484e` | Darker teal. Gradient ends, OG-image background gradient |
| `primary-tint` | `#eef6f6` | Very light teal. Alternating section backgrounds (Solution, Pricing) and hero top gradient |
| `accent` (CTA) | `#f5a623` | Warm amber. ALL primary CTA buttons ("Lock My First Delivery — $9"). Highest-contrast element on the page |
| `accent-dark` | `#d98e0b` | Amber hover/active state |
| `bg` | `#ffffff` | Default page background |
| `text` | `#111827` | Body + headings |
| `text-muted` | `#4b5563` | Sub-copy, captions |
| `text-faint` | `#9ca3af` | Legal lines, footer, strike-through prices |
| `border` | `#e5e7eb` | Card borders, dividers |
| `success` | `#16a34a` | "After" labels, checkmarks |
| `danger` | `#dc2626` | "Before" labels |

CTA buttons are **amber on white/teal**, not teal — the brief calls for max contrast and full-width on mobile. Secondary CTA ("Reserve a Founding Pro Spot — $19/mo") is an outline/teal-text button so the $9 stays visually primary (brief mod: "lead with per-delivery").

## Typography
- Family: `Inter` (Google Fonts `wght@400;500;600;700;800`), fallback `system-ui, -apple-system, "Segoe UI", Roboto, sans-serif`.
- h1: 3.25rem desktop / 2.25rem mobile, weight 800, letter-spacing -0.02em, line-height 1.1
- h2: 2.25rem desktop / 1.875rem mobile, weight 700
- h3: 1.5rem desktop / 1.25rem mobile, weight 600
- body: 1.125rem / 1rem mobile, weight 400, line-height 1.7
- eyebrow: 0.8125rem, weight 600, uppercase, letter-spacing 0.12em, color `primary`

## Spacing
- Section padding: 5rem top/bottom desktop, 3rem mobile
- Container: max-width 1024px (`max-w-5xl`), narrower 640–768px for text-heavy sections, 1.5rem horizontal padding
- Component gaps: 1.5rem standard, 3rem major separations

## Radius & Shadow
- Border radius: 0.75rem (cards, buttons), 1.5rem (pricing cards), 9999px (pills/badges)
- Card shadow: `0 4px 6px -1px rgba(0,0,0,.1), 0 2px 4px -2px rgba(0,0,0,.1)`
- CTA shadow: `0 10px 25px -5px rgba(245,166,35,.4)` (amber glow)

## Motion
- Buttons: `transform .15s ease, box-shadow .15s ease`; hover `translateY(-1px)`, active `translateY(0)`
- Trust badge pulse dot: 2s pulse
- Counter: 0.6s `countUp` fade-in once the live value loads

## Mobile-first notes (brief: buyers click from Reddit/Twitter on phones)
- Primary CTA is `w-full` below `sm:`, auto width above
- Test target viewport: 375px
- No external image dependencies anywhere — emoji + CSS gradients + one rendered OG PNG only

## Favicon
Inline SVG, lock emoji 🔒 (matches "download locked, payment is the key" hook).
