# Font Requirements

This CV style uses locally supplied fonts for reproducible PDF rendering.

Font files are intentionally not included in this repository due to
their respective licensing restrictions.

Download and install the required fonts before compiling.

## Academic CV

### Minion Pro
Used as the main serif font.

Required files:

- MinionPro-Regular.otf
- MinionPro-It.otf
- MinionPro-Bold.otf
- MinionPro-BoldIt.otf

Source:
Adobe Minion Pro

---

### Cabin
Used as the sans-serif font.

Required files:

- Cabin-Regular.ttf
- Cabin-Italic.ttf
- Cabin-Bold.ttf
- Cabin-BoldItalic.ttf

License:
SIL Open Font License

---

## Industry CV

### Calibri
Used as the primary body font.

Required files:

- calibri-regular.ttf
- calibri-italic.ttf

Note:
Calibri is a Microsoft font and is not redistributed here.

---

### Source Sans 3
Used for headings.

Required files:

- SourceSans3-SemiBold.ttf

License:
SIL Open Font License

---

### Spectral SC
Used for CV title styling.

Required files:

- SpectralSC-Regular.ttf

License:
SIL Open Font License

---

### Fira Mono
Used for monospaced text.

Required files:

- FiraMono-Regular.ttf
- FiraMono-Medium.ttf
- FiraMono-Bold.ttf

License:
SIL Open Font License

---

After placing the fonts in this directory, compile with XeLaTeX:

```bash
xelatex academic-cv.tex
```

or

```bash
bash compile.sh
```
