# Guide 5: French Academic Writing Setup

**Rédaction Académique en Français : Overleaf + Paperpal + Antidote**

⏱️ **Temps d'installation** : 1-2 heures
📝 **Prérequis** : Compte Overleaf, LaTeX basics, French proficiency
🎯 **Objectif** : 120,000 mots, grammaire parfaite, citations automatiques

---

## Part A: Overleaf Project Setup

### Step 1: Find U-Paris Thesis Template

**Search Overleaf Gallery**:
1. https://www.overleaf.com/latex/templates
2. Search: "PhD Thesis Template Université Paris" or "French thesis"
3. Download or "Open as Template"

**If no U-Paris template found**:

**Create custom template**:

```latex
\documentclass[12pt,a4paper,twoside]{book}

% French language support
\usepackage[french]{babel}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{csquotes}  % French quotes

% Bibliography
\usepackage[backend=biber,style=nature,sorting=none]{biblatex}
\addbibresource{kanna.bib}

% Figures & tables
\usepackage{graphicx}
\usepackage{booktabs}
\usepackage{caption}

% Hyperlinks
\usepackage[hidelinks]{hyperref}

% Document info
\title{Sceletium tortuosum : Analyse Interdisciplinaire des Savoirs Traditionnels San et Mécanismes Pharmacologiques}
\author{Mickael Souedan}
\date{2025}

\begin{document}

\maketitle

\frontmatter
\tableofcontents
\listoffigures
\listoftables

\mainmatter

\chapter{Introduction}
\input{chapters/ch01-introduction}

\chapter{Fondements Botaniques}
\input{chapters/ch02-botanique}

\chapter{Patrimoine Ethnobotanique Khoisan}
\input{chapters/ch03-ethnobotanie}

\chapter{Pharmacognosie et Neurobiologie}
\input{chapters/ch04-pharmacologie}

\chapter{Validation Clinique}
\input{chapters/ch05-clinique}

\chapter{Circuits de l'Addiction}
\input{chapters/ch06-addiction}

\chapter{Enjeux Juridiques et Éthiques}
\input{chapters/ch07-juridique}

\chapter{Synthèse et Perspectives}
\input{chapters/ch08-synthese}

\backmatter
\printbibliography

\end{document}
```

### Step 2: Project Structure

**Create folders in Overleaf**:
```
KANNA-Thesis/
├── main.tex
├── kanna.bib (upload from zotero-export/)
├── chapters/
│   ├── ch01-introduction.tex
│   ├── ch02-botanique.tex
│   ├── ch03-ethnobotanie.tex
│   ├── ch04-pharmacologie.tex
│   ├── ch05-clinique.tex
│   ├── ch06-addiction.tex
│   ├── ch07-juridique.tex
│   └── ch08-synthese.tex
└── figures/
    ├── chapter-01/
    ├── chapter-02/
    └── ...
```

**Upload Figures**:
```bash
# From KANNA project:
# Upload contents of assets/figures/ to Overleaf figures/
```

### Step 3: Configure Bibliography

**In main.tex**:

```latex
% Use biblatex (modern, better than bibtex)
\usepackage[backend=biber,
            style=nature,  % or: apa, ieee, authoryear
            sorting=none,   % Order by citation
            maxbibnames=99]{biblatex}

\addbibresource{kanna.bib}

% In document:
\printbibliography[title=Références]
```

**Upload** `kanna.bib` from Zotero:
- Copy from: `~/LAB/projects/KANNA/literature/zotero-export/kanna.bib`
- Upload to Overleaf project root

**Test Citation**:
```latex
\chapter{Introduction}

Les alcaloïdes de \textit{Sceletium tortuosum} présentent une
double inhibition SERT/PDE4 \parencite{klak2025}.

% Compile (Ctrl+S or Cmd+S)
% Should render: (Klak et al., 2025)
```

---

## Part B: Paperpal for Overleaf (Free Grammar Checker)

### What is Paperpal?

**Launched**: January 2025
**Features**:
- AI grammar checker for LaTeX
- Trained on academic papers
- **Free unlimited** grammar checking
- Preserves LaTeX code/formatting

### Install Browser Extension

**Chrome/Edge**:
1. Visit https://paperpal.com/paperpal-for-overleaf
2. "Add to Chrome" (or Edge)
3. Install extension

**Firefox**:
- Currently not available (as of Jan 2025)
- Use Chrome/Edge for Overleaf

### Enable in Overleaf

1. Open your KANNA thesis project
2. Toolbar (top): Look for "Paperpal" icon
3. Click to enable
4. Grant access to document

### How to Use

**Real-Time Suggestions**:
1. Type in Overleaf editor
2. Paperpal underlines errors (green/red)
3. Hover over underline → See suggestion
4. Click "Accept" or "Ignore"

**Example**:
```latex
% You type:
Les résultats montre que mesembrine est efficace.

% Paperpal suggests:
Les résultats montrent que la mesembrine est efficace.
         ^^^^^^^^      ^^^
         (verb agreement) (article needed)
```

**Manual Check**:
1. Select text passage
2. Right-click → "Check with Paperpal"
3. Review all suggestions
4. Apply/reject

### French Language Support

**Configure Language**:
- Paperpal detects language automatically
- For bilingual thesis (French + English abstracts):
  - Mark English sections: `\begin{otherlanguage}{english}...\end{otherlanguage}`

---

## Part C: Antidote (Comprehensive French Checker)

### Why Antidote?

**Beyond Paperpal**:
- Deeper French grammar (verb moods, subjunctive)
- Style analysis (academic tone, repetitions)
- French-specific (Paperpal is English-first)

**Pricing**: ~€150/year student license

### Install Antidote Desktop

1. Purchase: https://www.antidote.info/fr/acheter
   - Choose: "Antidote 12" (latest version)
   - License: Student (50% discount)
2. Download installer (Windows/Mac)
3. Install (requires ~1.5GB)
4. Activate with license key

### Workflow (Weekly Deep Check)

**Overleaf → Antidote Workflow**:

1. **Friday**: Download LaTeX source from Overleaf
   ```bash
   # Overleaf → Menu → Source → Download ZIP
   cd ~/LAB/projects/KANNA/writing/overleaf-backup/
   unzip kanna-thesis-source.zip
   ```

2. **Open in Antidote-Compatible Editor**:
   ```bash
   # Linux: TeXstudio, Texmaker
   # Mac: TeXShop, Texpad
   # Windows: TeXnicCenter, WinEdt

   # Example (TeXstudio):
   texstudio chapters/ch01-introduction.tex
   ```

3. **Run Antidote Corrector**:
   - Select all text (Ctrl+A / Cmd+A)
   - Right-click → Antidote → Corrector
   - Or: Hotkey (F2 by default)

4. **Review Suggestions**:
   - **Green**: Grammar errors
   - **Yellow**: Style suggestions
   - **Blue**: Typography (spaces, punctuation)

5. **Apply Corrections**:
   - Click suggestion → Replace
   - Ignore false positives (LaTeX commands)

6. **Re-Upload to Overleaf**:
   ```bash
   # Copy corrected chapter back to Overleaf
   # Overleaf → Upload → Replace ch01-introduction.tex
   ```

### Antidote Features

**Grammaire** (Grammar):
- Verb conjugation (imparfait vs passé composé)
- Subjunctive mood detection
- Agreement (gender, number): *les résultats montrent*
- Relative pronouns: *dont*, *duquel*, *auquel*

**Style**:
- Academic register: Avoid *on*, use *nous* or passive
- Repetitions: Highlight overused words
- Sentence length: Warn if too long (>40 words)
- Clarity: Suggest simpler phrasing

**Dictionnaires** (Dictionaries):
- Definitions (French-French)
- Synonyms & antonyms
- Conjugation tables (all tenses)
- Etymology

### LaTeX-Specific Settings

**Configure Antidote to Ignore LaTeX**:
1. Antidote → Settings → Filters
2. ✅ "Ignore text in \command{}"
3. ✅ "Ignore text in $$...$$"
4. ✅ "Ignore text in environments: \begin{...}\end{...}"

---

## Part D: French Academic Phrasing

### Common Thesis Phrases

**Introduction**:
```latex
% Présenter la problématique
Cette étude vise à démontrer que...
L'objectif de cette thèse est d'analyser...
Nous proposons d'examiner...

% Contexte
Dans le contexte actuel de...
Compte tenu de...
Au regard de...
```

**Méthodologie**:
```latex
% Décrire les méthodes
Nous avons employé une approche mixte combinant...
Les données ont été collectées auprès de...
L'analyse statistique a été réalisée avec le logiciel R...
```

**Résultats**:
```latex
% Présenter les résultats
Les résultats montrent que...
Il ressort de cette analyse que...
On observe une corrélation significative entre...
Ces données suggèrent que...
```

**Discussion**:
```latex
% Interpréter
Ces résultats confirment l'hypothèse selon laquelle...
Nos travaux mettent en évidence...
Il convient de souligner que...
Toutefois, il est important de noter que...
```

**Conclusion**:
```latex
% Conclure
En conclusion, nos travaux démontrent que...
Cette étude contribue à...
Les perspectives ouvertes par cette recherche incluent...
```

### Avoid Common Mistakes

**❌ Informal**:
```latex
On a trouvé que...  % Too casual
```

**✅ Academic**:
```latex
Nous avons observé que...
Les résultats indiquent que...
```

**❌ Anglicisms**:
```latex
Nous avons performé une analyse...  % "Performed" (English)
```

**✅ Correct**:
```latex
Nous avons effectué une analyse...
Nous avons réalisé une analyse...
```

---

## Part E: Citation Workflow

### Citing in French LaTeX

**Parenthetical** (most common):
```latex
\parencite{klak2025}  → (Klak et al., 2025)
```

**Textual** (in sentence):
```latex
Selon \textcite{klak2025}, la taxonomie de \textit{Sceletium}...
→ Selon Klak et al. (2025), la taxonomie...
```

**Multiple Citations**:
```latex
\parencite{klak2025,terberg2013,harvey2011}
→ (Klak et al., 2025; Terberg et al., 2013; Harvey et al., 2011)
```

**Page Numbers**:
```latex
\parencite[p.~42]{klak2025}  → (Klak et al., 2025, p. 42)
\parencite[pp.~42-45]{klak2025}  → (Klak et al., 2025, pp. 42-45)
```

### Bibliography Styles for French Theses

**Nature Style** (numeric):
```latex
\usepackage[style=nature]{biblatex}
% Output: [1] Klak C, et al. (2025) ...
```

**APA Style** (author-year):
```latex
\usepackage[style=apa]{biblatex}
% Output: Klak, C., et al. (2025). ...
```

**French Conventions**:
```latex
\usepackage[french]{babel}
\usepackage[style=authoryear,babel=other]{biblatex}

% Customizations:
\DeclareFieldFormat{pages}{#1}  % No "p." prefix
\renewcommand*{\finalnamedelim}{ et }  % Use "et" instead of "and"
```

---

## Part F: Managing Long Documents

### Chapter Files

**In main.tex**:
```latex
\chapter{Introduction}
\input{chapters/ch01-introduction}  % Loads separate file
```

**In chapters/ch01-introduction.tex**:
```latex
% Don't include \documentclass, \begin{document}, etc.
% Just content:

\section{Problématique Interdisciplinaire}

Le \textit{Sceletium tortuosum} présente...

\subsection{Biopiraterie Zembrin®}

L'analyse des brevets...
```

### Cross-References

**Label Sections**:
```latex
\section{Mécanismes PDE4/SERT}
\label{sec:mechanisms-pde4-sert}
```

**Reference Later**:
```latex
Comme discuté dans la Section \ref{sec:mechanisms-pde4-sert}...
% Compiles to: "Section 4.2" (automatic numbering)
```

**Figures**:
```latex
\begin{figure}[htbp]
  \centering
  \includegraphics[width=0.8\textwidth]{figures/chapter-03/bei-by-community.png}
  \caption{Indice Ethnobotanique Botanique (BEI) par communauté.}
  \label{fig:bei-by-community}
\end{figure}

% Reference:
La Figure \ref{fig:bei-by-community} montre...
```

### Word Count Tracking

**In Overleaf**:
- Menu → Word Count
- Shows: Total words, words per chapter

**Target**: 120,000 words total
- Ch01: ~15,000 words
- Ch02-03: ~12,000 each
- Ch04-06: ~18,000 each
- Ch07-08: ~10,000 each

**Track Progress**:
```bash
# Create tracking file
echo "Date,Chapter,Words,Total" > ~/LAB/projects/KANNA/writing-progress.csv

# Weekly update
echo "2025-10-10,Ch01,3500,3500" >> writing-progress.csv
```

---

## Part G: Bilingual Abstracts

### French Abstract (Required)

```latex
\chapter*{Résumé}
\addcontentsline{toc}{chapter}{Résumé}

Cette thèse présente une analyse interdisciplinaire du
\textit{Sceletium tortuosum}, combinant botanique,
ethnobotanique, pharmacologie et enjeux juridiques.

\textbf{Mots-clés} : \textit{Sceletium tortuosum}, ethnobotanie,
PDE4, SERT, Khoisan, biopiraterie, FPIC
```

### English Abstract (Often Required)

```latex
\begin{otherlanguage}{english}
\chapter*{Abstract}
\addcontentsline{toc}{chapter}{Abstract}

This thesis presents an interdisciplinary analysis of
\textit{Sceletium tortuosum}, combining botany, ethnobotany,
pharmacology, and legal issues.

\textbf{Keywords}: \textit{Sceletium tortuosum}, ethnobotany,
PDE4, SERT, Khoisan, biopiracy, FPIC
\end{otherlanguage}
```

---

## Part H: Final Submission Preparation

### Checklist (Before Defense)

**Content**:
- [ ] All chapters complete (120,000 words ±10%)
- [ ] French abstract (300-500 words)
- [ ] English abstract (300-500 words)
- [ ] List of figures, tables
- [ ] Bibliography (500+ references)
- [ ] Acknowledgments (remerciements)

**Quality**:
- [ ] Full Antidote check (all chapters)
- [ ] Paperpal review (final pass)
- [ ] Supervisor approval (all chapters)
- [ ] Community validation (ethnobotany sections)

**Formatting**:
- [ ] Page numbers correct
- [ ] All figures 300 DPI
- [ ] Cross-references working (\ref{} compiles correctly)
- [ ] Table of contents auto-generated
- [ ] Bibliography compiles (no errors)

**Legal**:
- [ ] FPIC compliance verified
- [ ] Informed consent forms archived
- [ ] De-identified data only in appendices
- [ ] Khoisan knowledge holders acknowledged

### Export Final PDF

**Overleaf**:
1. Menu → Download PDF
2. Save as: `Souedan_2025_These_Sceletium_tortuosum_UParis.pdf`

**Verify Quality**:
```bash
# Check PDF properties
pdfinfo Souedan_2025_These_Sceletium_tortuosum_UParis.pdf

# Should show:
#   Pages: ~300-400
#   File size: 10-30 MB (with figures)
#   PDF version: 1.5+
```

---

## Troubleshooting

### Issue 1: Bibliography Not Compiling

**Symptom**: `[klak2025]` appears instead of citation

**Solution**:
1. Compile **twice** (biber needs 2 passes)
2. Check `kanna.bib` uploaded to Overleaf
3. Verify citekey spelling matches exactly
4. Clear cache: Menu → Clear cached files → Recompile

### Issue 2: French Accents Broken

**Symptom**: "é" appears as "Ã©"

**Solution**:
```latex
% In preamble:
\usepackage[utf8]{inputenc}  % MUST be present
\usepackage[T1]{fontenc}     % Correct font encoding
```

### Issue 3: Paperpal Suggests Incorrect Changes

**Problem**: Suggests changing valid French to English

**Solution**:
- Mark French sections explicitly:
  ```latex
  \begin{otherlanguage}{french}
  % Your French text
  \end{otherlanguage}
  ```
- Or: Ignore Paperpal for French, use Antidote only

---

## Best Practices

**Daily Writing**:
- Target: 500-1000 words/day
- Use Paperpal for immediate feedback
- Save often (Overleaf auto-saves, but Cmd+S is habit)

**Weekly Review**:
- Friday: Download source → Antidote deep check
- Track progress: Update `writing-progress.csv`
- Commit to Git: `git add writing/ && git commit -m "Ch01: +750 words"`

**Monthly Milestones**:
- Month 1-3: Ch01 complete (15,000 words)
- Month 4-12: Ch02-03 complete (24,000 words)
- Month 13-24: Ch04-05 complete (36,000 words)
- Month 25-36: Ch06-07 complete (28,000 words)
- Month 37-42: Ch08 + final revisions (17,000 words)

---

## Further Resources

**LaTeX**:
- Overleaf tutorials: https://www.overleaf.com/learn
- LaTeX Wikibook: https://en.wikibooks.org/wiki/LaTeX
- French typography: https://www.ctan.org/pkg/babel-french

**French Academic Writing**:
- *Bien rédiger sa thèse* (Michel Kalika)
- *L'Art de la thèse* (Michel Beaud)

---

**Last Updated**: October 2025
**Target**: 120,000 words by Month 42
**Quality**: Grammar-perfect via Paperpal + Antidote
