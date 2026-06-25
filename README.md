# kshafayetCV

A modular LaTeX CV style for creating clean academic and industry resumes.

`kshafayetCV` is designed around a single reusable style file that supports
different CV workflows through configurable modes:

- **academic** — optimized for research, academia, publications, and longer CVs
- **industry** — optimized for data science, software, and technical job applications

The style is based on [CleanCV](https://github.com/giladturok/CleanCV) by
[Gilead Turok](https://github.com/giladturok) and has been substantially modified 
and extended with custom typography, layout systems, font management, CV-specific 
commands, and academic/industry configurations.


## Features

- Single reusable `.sty` file
- Academic and industry CV modes
- Custom font configuration with `fontspec`
- XeLaTeX/LuaLaTeX support
- Clean section formatting
- Contact bar with Font Awesome icons
- Academic icons (Google Scholar, ORCID, etc.)
- Compact industry-oriented layout
- Academic bibliography support with `biblatex`
- Reusable commands for:
  - education entries
  - work experience
  - awards
  - publications
  - skills and short entries

## Requirements

### LaTeX engine

This style requires:

- XeLaTeX (recommended)
- LuaLaTeX

It is **not compatible with pdfLaTeX** because it uses `fontspec` for custom
font loading.

Compile using:

```bash
bash compile.sh job-cv/job-cv.tex xelatex
```

```bash
bash compile.sh academic-cv/academic-cv.tex xelatex
```


# Usage

## 1. Clone the repository

```
git clone https://github.com/yourusername/kshafayetCV.git
cd kshafayetCV
```


## 2. Import the style file

Place your CV file following the repository structure:

```latex
\documentclass[11pt]{article}

\usepackage[type=academic]{styles/kshafayetCV}

\begin{document}

\cvname{Your Name}

\contactbar
{email@example.com}
{yourwebsite.com}
{githubusername}
{linkedinusername}
{google-scholar-url}
{phone-number}
{location}

\end{document}
```

# CV Types

The package supports two styles.

## Academic CV

Use:

```latex
\usepackage[type=academic]{styles/kshafayetCV}
```

Designed for:

- PhD applications
- research positions
- academic CVs
- publications-heavy documents

Features:

- serif body typography
- larger spacing
- publication-friendly layout
- page numbering


## Industry CV

Use:

```latex
\usepackage[type=industry]{styles/kshafayetCV}
```

Designed for:

- data science roles
- software engineering roles
- industry research positions

Features:

- compact layout
- sans-serif typography
- recruiter-friendly spacing
- minimal visual hierarchy


# Fonts

See [fonts/README.md](fonts/README.md)

# License

The CV style [kshafayetCV.sty](styles/kshafayetCV.sty) is released under the MIT 
License.

This project is derived from: [CleanCV](https://github.com/giladturok/CleanCV)
by [Gilead Turok](https://github.com/giladturok)

Original work:

```yaml
CleanCV
Copyright (c) 2025 Gilad Turok
Licensed under the MIT License
```

Modifications and extensions:

```yaml
Copyright (c) 2026 Shafayet Khan Shafee
```

The original attribution is retained in the style file.

Font files are separate third-party software and retain their own licenses.

See the individual license files included with each font:

- `OFL.txt`
- `COPYRIGHT.txt`


# Acknowledgements

Thanks to:

- [Gilead Turok](https://github.com/giladturok) for the original CleanCV framework
- The LaTeX community for excellent packages and documentation
