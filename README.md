# ReportKit

ReportKit is a local-first, Git-friendly reporting workflow for penetration
tests and security assessments. It turns Markdown, YAML metadata, and evidence
files into a polished HTML and PDF report without requiring a reporting server
or database.

It is intentionally small and opinionated:

- write the narrative and findings in Markdown;
- keep evidence beside the report;
- validate the project before delivery;
- produce a self-contained HTML file and print-ready PDF with one command.

The included example describes a completely fictional assessment. ReportKit
does not include certification exam content, client data, credentials, flags,
or proprietary report templates.

## Quick start

Requirements:

- Python 3.10 or newer with PyYAML
- Pandoc 3.x
- WeasyPrint 62 or newer
- ImageMagick `import` for the optional screenshot helper

On Debian or Kali:

```bash
sudo apt install pandoc weasyprint python3-yaml imagemagick
git clone <repository-url> reportkit
cd reportkit
make preflight
make build
```

The example output is written to:

```text
examples/fictional-assessment/_build/
```

To start a real report, copy the example while excluding generated output:

```bash
cp -a examples/fictional-assessment my-assessment
rm -rf my-assessment/_build
```

Then replace the fictional metadata and content:

```bash
$EDITOR my-assessment/report.yml
$EDITOR my-assessment/report.md
./scripts/reportkit new-finding my-assessment "Exposed administrative interface" --severity High
./scripts/reportkit preflight my-assessment
./scripts/reportkit build my-assessment
```

## Project layout

```text
my-assessment/
├── report.yml          # cover, footer, output, and engagement metadata
├── report.md           # executive narrative, scope, and methodology
├── findings/           # one Markdown file per finding, sorted by filename
├── appendices/         # optional Markdown appendices, sorted by filename
├── evidence/           # screenshots, diagrams, and other report assets
└── _build/             # generated output; ignored by Git
```

The build concatenates `report.md`, the files under `findings/`, and optional
files under `appendices/`. Keeping findings separate reduces merge conflicts
and makes it easy to reuse or review an individual finding.

## Commands

Build HTML and PDF:

```bash
./scripts/reportkit build path/to/project
```

Run delivery checks without building:

```bash
./scripts/reportkit preflight path/to/project
```

Create the next numbered finding:

```bash
./scripts/reportkit new-finding path/to/project "Finding title" --severity Critical
```

Capture a numbered screenshot:

```bash
./scripts/capture-evidence path/to/project F-003 "proof of access"
./scripts/capture-evidence -w -d 3 path/to/project F-003 "active window"
```

Remove generated output:

```bash
./scripts/reportkit clean path/to/project
```

## Preflight checks

Preflight currently detects:

- missing required metadata or project files;
- unresolved `TBD`, `TODO`, `FIXME`, and `CHANGEME` markers;
- missing local Markdown images;
- absolute workstation paths such as `/home/name` or `C:\Users\name`;
- common private-key, token, password, and flag patterns;
- findings whose filename does not begin with `F-NNN-`;
- duplicate finding IDs and unknown severity labels.

Secret detection is intentionally conservative and cannot prove that a report
is safe to publish. Always perform a human review, inspect Git history, and
confirm the distribution rules for the assessment material.

## Customization

Edit `templates/theme.css` for typography and print design. Edit
`templates/report.html` for the cover and page structure. The template uses
Pandoc variables from the project's `report.yml`.

The CSS is designed for A4 output. Change the `@page` size and margins if your
delivery standard requires Letter paper.

## Security and privacy

Treat report repositories as sensitive. Use a private remote by default,
encrypt retained evidence as required by your rules of engagement, and never
commit live credentials or client data merely because `_build/` is ignored.
Self-contained HTML embeds evidence and is just as sensitive as the PDF.

## License

ReportKit is released under the MIT License.
