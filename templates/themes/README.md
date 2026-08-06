# ReportKit Theme Overrides

These optional themes load after `templates/theme.css` and preserve the
standard ReportKit document structure.

## Available themes

- `halo.css` — military science-fiction HUD styling with angular panels,
  tactical greens, cyan instrumentation, and restrained technical typography.
- `eight-bit.css` — retro game styling with pixel-like typography, block
  shadows, high-contrast status colors, and square interface components.
- `cyberpunk.css` — original neon-dystopian styling with acid yellow, cyan,
  magenta, hard-edged warning panels, scan lines, and glitch-like accents.

## Render a themed report

Use ReportKit's normal merged Markdown and HTML template, then pass the base
theme followed by the selected override:

```bash
pandoc PROJECT/_build/REPORT.merged.md \
  --from=gfm+attributes+fenced_divs+bracketed_spans \
  --to=html5 --standalone --wrap=none \
  --template=templates/report.html \
  --css=templates/theme.css \
  --css=templates/themes/halo.css \
  --embed-resources --toc --toc-depth=2 \
  --metadata-file=PROJECT/report.yml \
  --resource-path=PROJECT:PROJECT/evidence:PROJECT/findings:PROJECT/appendices \
  --output=PROJECT/_build/report-halo.html
```

Replace `halo.css` with `eight-bit.css` or `cyberpunk.css` for the other
variants. ReportKit's standard preflight should still be run before rendering.
