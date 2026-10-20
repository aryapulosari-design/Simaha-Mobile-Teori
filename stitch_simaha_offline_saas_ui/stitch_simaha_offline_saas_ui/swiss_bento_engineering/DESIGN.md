---
name: Swiss Bento Engineering
colors:
  surface: '#f8f9ff'
  surface-dim: '#cbdbf5'
  surface-bright: '#f8f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#eff4ff'
  surface-container: '#e5eeff'
  surface-container-high: '#dce9ff'
  surface-container-highest: '#d3e4fe'
  on-surface: '#0b1c30'
  on-surface-variant: '#3d4947'
  inverse-surface: '#213145'
  inverse-on-surface: '#eaf1ff'
  outline: '#6d7a77'
  outline-variant: '#bcc9c6'
  surface-tint: '#006a61'
  primary: '#00685f'
  on-primary: '#ffffff'
  primary-container: '#008378'
  on-primary-container: '#f4fffc'
  inverse-primary: '#6bd8cb'
  secondary: '#565e74'
  on-secondary: '#ffffff'
  secondary-container: '#dae2fd'
  on-secondary-container: '#5c647a'
  tertiary: '#4b41e1'
  on-tertiary: '#ffffff'
  tertiary-container: '#645efb'
  on-tertiary-container: '#fffbff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#89f5e7'
  primary-fixed-dim: '#6bd8cb'
  on-primary-fixed: '#00201d'
  on-primary-fixed-variant: '#005049'
  secondary-fixed: '#dae2fd'
  secondary-fixed-dim: '#bec6e0'
  on-secondary-fixed: '#131b2e'
  on-secondary-fixed-variant: '#3f465c'
  tertiary-fixed: '#e2dfff'
  tertiary-fixed-dim: '#c3c0ff'
  on-tertiary-fixed: '#0f0069'
  on-tertiary-fixed-variant: '#3323cc'
  background: '#f8f9ff'
  on-background: '#0b1c30'
  surface-variant: '#d3e4fe'
typography:
  headline-xl:
    fontFamily: Plus Jakarta Sans
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.03em
  headline-xl-mobile:
    fontFamily: Plus Jakarta Sans
    fontSize: 26px
    fontWeight: '700'
    lineHeight: 34px
    letterSpacing: -0.025em
  headline-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
    letterSpacing: -0.025em
  headline-lg-mobile:
    fontFamily: Plus Jakarta Sans
    fontSize: 22px
    fontWeight: '700'
    lineHeight: 30px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
    letterSpacing: -0.02em
  headline-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 16px
    fontWeight: '600'
    lineHeight: 24px
    letterSpacing: -0.01em
  body-lg:
    fontFamily: Inter
    fontSize: 15px
    fontWeight: '400'
    lineHeight: 22px
    letterSpacing: -0.01em
  body-md:
    fontFamily: Inter
    fontSize: 13px
    fontWeight: '400'
    lineHeight: 20px
    letterSpacing: 0em
  body-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 18px
    letterSpacing: 0em
  label-code:
    fontFamily: JetBrains Mono
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: -0.02em
  label-code-sm:
    fontFamily: JetBrains Mono
    fontSize: 11px
    fontWeight: '500'
    lineHeight: 14px
    letterSpacing: -0.01em
  metric-display:
    fontFamily: Plus Jakarta Sans
    fontSize: 30px
    fontWeight: '700'
    lineHeight: 36px
    letterSpacing: -0.03em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  gutter: 0.75rem
  gutter-tablet: 0.75rem
  gutter-mobile: 0.5rem
  margin: 1.5rem
  margin-mobile: 1rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 0.75rem
  space-lg: 1rem
  space-xl: 1.5rem
---

## Brand & Style

The design system embodies a high-density, Swiss modernist SaaS aesthetic built for data-intensive infrastructure platforms and mission-critical operations. The visual posture is clinical, structured, and deliberate—balancing technical rigor with executive clarity.

Key style characteristics:
- **Modular Bento Grid**: Structured modularity where every widget, chart, and metric block aligns to a predictable geometric rhythm.
- **Architectural Whitespace & Contrast**: A surgical juxtaposition between the crisp `#FFFFFF` analytical cards and the muted `#F4F6F9` base canvas.
- **High-Density Utility**: Optimized for visual scanning with information-dense layouts, precise monospaced token strings, tight tracking, and concise tabular readouts.
- **Micro-Delight through Precision**: Refined hairline strokes (`1px`), micro sparklines, and segmented pills replace gratuitous skeuomorphic decoration.

## Colors

The palette leverages high-contrast functional color assignments to drive rapid scanning across telemetry, identity tokens, and infrastructure metrics.

- **Primary (`#0D9488` - Electric Emerald)**: Reserved for primary action states, active dashboard context switches, healthy status indicators, and key operational nodes.
- **Secondary (`#0F172A` - Deep Slate Ink)**: Serves as the primary structural anchor for headlines, key figures, and high-emphasis data visualizations.
- **Tertiary (`#4F46E5` - Indigo Violaceous)**: Utilized for auxiliary systems, synthetic API metrics, and secondary query interactions.
- **Canvas (`#F4F6F9` - Cool Alabaster)**: The base neutral backdrop that establishes contrast against card containers.
- **Surface (`#FFFFFF` - Pure White)**: Applied exclusively to modular Bento cards, elevated drawers, and dropdown contexts.
- **Semantic Accents**:
  - Positive/Mint: `#10B981` (uptime, positive yield, nominal latency)
  - Warning/Amber: `#F59E0B` (degraded throughput, memory pressure)
  - Critical/Crimson: `#E11D48` (HMAC authentication failures, fatal incidents)
  - Hairline Border: `#E4E7EC`

## Typography

Typography establishes an assertive visual hierarchy through the pairing of three specialized typefaces:

- **Plus Jakarta Sans**: Drives structural titles and oversized numeric values. Metrics feature tight negative letter-spacing (`-0.025em` to `-0.03em`) and tabular numeric variants (`tnum`) to eliminate layout jitter during real-time data streaming.
- **Inter**: Governs continuous reading experiences, descriptions, tooltips, and secondary card annotations with neutral, high-legibility optical properties.
- **JetBrains Mono**: Assigned to all cryptographic artifacts, hash tokens (SHA-256), IP addresses, serial IDs, and micro code badges. Monospaced elements use compact vertical alignments and reduced tracking to maximize data efficiency within constrained data tables.

## Layout & Spacing

The architecture operates on a strict 12-column modular Bento Grid system engineered around a `12px` (`0.75rem`) universal grid gap and `16px` (`1rem`) internal card padding.

- **Desktop (1200px+)**: 12-column dynamic layout. Bento units span 3, 4, 6, 8, or 12 columns. Fixed margins of `24px` (`1.5rem`) anchor the dashboard canvas.
- **Tablet (768px - 1199px)**: 6-column fluid structure. Modular widgets collapse from 3-column triplets into 2-column duplexes; gutters maintain `12px`.
- **Mobile (< 768px)**: Single-column linear stack. Cards collapse to 100% width with `8px` (`0.5rem`) vertical gaps and `16px` outer page margins.
- **Vertical Rhythm**: Layout components adhere to a 4px sub-grid baseline. All metric groupings, metadata rows, and inline charts align cleanly to `space-xs` (4px), `space-sm` (8px), `space-md` (12px), `space-lg` (16px), and `space-xl` (24px).

## Elevation & Depth

Visual separation relies on razor-sharp hairlines and ultra-diffused micro-shadows rather than heavy drop-shadows or stark structural fills:

- **Base Card Elevation**: `box-shadow: 0 2px 6px rgba(16, 24, 40, 0.03);` paired with a crisp `border: 1px solid #E4E7EC`. Cards render flat against the `#F4F6F9` canvas, providing tactile distinction without visual weight.
- **Interactive Card Hover**: Translates `-1px` vertically with an adjusted ambient shadow of `0 6px 16px rgba(16, 24, 40, 0.06)` and dynamic border coloration transitioning to `#CBD5E1`.
- **Floating Modals & Flyouts**: Layered with an ambient compound drop: `0 12px 32px -4px rgba(16, 24, 40, 0.08), 0 4px 12px -2px rgba(16, 24, 40, 0.03)` with a solid `#FFFFFF` surface and `1px solid #E4E7EC`.
- **Context Bar & Sticky Elements**: Bound to the top viewport with `backdrop-filter: blur(8px)` and a subtle bottom border (`1px solid #E4E7EC`), ensuring continuous contextual orientation.

## Shapes

The design system standardizes on a balanced `16px` (`1rem`) border radius across all primary Bento cards and functional containers.

- **Cards & Data Modules**: Fixed `16px` (`1rem`) corner radius, producing a softened technical silhouette.
- **Inner Embedded Containers**: Sub-sections, integrated sparkline canvases, and nested data tables within cards use `8px` to `12px` radii to maintain concentric edge consistency.
- **Controls & Segmented Switchers**: Inputs, buttons, and segmented pills employ a refined `8px` corner radius or fully rounded pill geometry (`9999px`) for discrete binary toggles and contextual tags.

## Components

### SaaS Context Bar
Positioned at the top of the interface: a 56px fixed utility bar featuring breadcrumb telemetry, workspace switcher, environment pill indicator (e.g., `prod-us-east-1` in `label-code`), and user session controls. Framed by a 1px solid `#E4E7EC` border bottom.

### Bento Cards
- **Structure**: Surface `#FFFFFF`, border `1px solid #E4E7EC`, radius `16px`, padding `16px`.
- **Header**: Flex container containing title (`headline-sm`), optional subtitle (`body-sm`), and right-aligned context action (e.g., segmented interval selector or status badge).
- **Metric Content**: Primary tabular metric (`metric-display` in `#0F172A`) paired with inline percentage trend pill (Mint for positive, Crimson for negative).
- **Embedded Sparklines**: Edge-to-edge or padded SVG micro-charts embedded directly below metric blocks with zero-fill gradients and stroke width `1.5px`.

### Segmented Pill Controls
- Encased in a `#F1F5F9` neutral track with `4px` interior padding and an `8px` radius.
- Active item uses surface `#FFFFFF`, text `#0F172A`, and a micro-shadow `0 1px 3px rgba(16, 24, 40, 0.08)`.
- Inactive items use transparent backgrounds with `#64748B` typography, transitioning on hover.

### Buttons
- **Primary**: Background `#0D9488`, text `#FFFFFF`, font `Inter` 13px weight 600, radius `8px`, height `36px`, padding `0 14px`. Hover state: `#0F766E`.
- **Secondary**: Surface `#FFFFFF`, border `1px solid #E4E7EC`, text `#0F172A`. Hover state: background `#F8FAFC`.
- **Destructive**: Surface `#FFFFFF`, border `1px solid #FECDD3`, text `#E11D48`. Hover state: background `#FFF1F2`.

### Code Badges & Technical Tokens
- Used for NIM strings, SHA-256 HMAC values, recovery codes, and IPK metrics.
- Styled using font `JetBrains Mono` at `11px` or `12px`, background `#F8FAFC`, border `1px solid #E2E8F0`, padding `2px 6px`, radius `4px`, and text `#334155`. Interactive tokens feature an integrated one-click copy icon.

### Form Inputs & Checkboxes
- **Inputs**: Background `#FFFFFF`, border `1px solid #E4E7EC`, radius `8px`, height `36px`, text `13px Inter`. Focus state triggers a crisp ring: `box-shadow: 0 0 0 3px rgba(13, 148, 136, 0.15); border-color: #0D9488;`.
- **Checkboxes & Radios**: 16px square/circle with `1.5px` border `#CBD5E1`. Active state fills with `#0D9488` carrying an interior pure white check or radio dot.