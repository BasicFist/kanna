# Guide 1: Literature Workflow Setup

**Flux de Travail Littérature : Elicit → Zotero → Obsidian → Overleaf**

⏱️ **Temps d'installation** : 3-4 heures
📚 **Prérequis** : Compte académique, ordinateur Windows/Mac/Linux
🎯 **Objectif** : Système intégré pour découvrir, organiser, synthétiser et citer 500+ articles

---

## Table des Matières / Table of Contents

1. [Elicit: AI Literature Discovery](#part-a-elicit-ai-literature-discovery)
2. [Zotero + Better BibTeX: Reference Management](#part-b-zotero--better-bibtex)
3. [Obsidian: Knowledge Graph](#part-c-obsidian-knowledge-graph)
4. [Overleaf: LaTeX Thesis Writing](#part-d-overleaf-integration)
5. [Daily Workflow](#part-e-daily-workflow)
6. [Troubleshooting](#troubleshooting)

---

## Part A: Elicit AI Literature Discovery

### Step 1: Create Free Account

1. Navigate to https://elicit.com/
2. Click "Sign Up" (top right)
3. Use your **academic email** (e.g., @u-paris.fr)
   - This may unlock higher usage limits
4. Verify email address

### Step 2: Configure Search Preferences

**First Search Test:**
```
Query: "Sceletium tortuosum pharmacology"
```

**Elicit will**:
- Search 138M+ papers in Semantic Scholar database
- Extract key data (methods, outcomes, sample sizes)
- Summarize findings
- Show citation counts

**Best Practices**:
- Use semantic search (natural language): ✅ "What are the mechanisms of Sceletium alkaloids?"
- Avoid keyword-only search: ❌ "Sceletium AND alkaloids AND mechanisms"
- Elicit understands context and synonyms

### Step 3: Advanced Search Features

**Filter by**:
- Publication date: Last 5 years (2020-2025)
- Study type: RCTs, systematic reviews, meta-analyses
- Journal quality: Q1 journals only
- Language: English + French

**Extract Data**:
- IC50 values from pharmacology papers
- Sample sizes from clinical trials
- Ethnobotanical indices (BEI, ICF) from field studies

**Example Advanced Query**:
```
Query: "clinical trials Sceletium anxiety depression 2020-2025"
Filter: Study type = RCT
Extract: Sample size, intervention, primary outcome, effect size
```

### Step 4: Export to Zotero

Once you have 50+ relevant papers:

1. Select all papers (checkbox in results)
2. Click "Export" button (top right)
3. Choose format: **RIS** (Zotero-compatible)
4. Download `elicit-export.ris` file

**Save to**: `~/Downloads/elicit-export.ris` (temporary, will import to Zotero next)

---

## Part B: Zotero + Better BibTeX

### Step 1: Install Zotero

**Download**:
- Visit https://www.zotero.org/download/
- Download Zotero 7.0+ for your OS
- Install desktop app

**Verify Installation**:
```bash
# Linux/Mac
which zotero
# Should return: /usr/bin/zotero or similar

# Windows: Check Start Menu for "Zotero"
```

### Step 2: Install Better BibTeX Plugin

**Why Better BibTeX?**
- Auto-generates citation keys (`klak2025`, `terberg2013`)
- Auto-exports to `.bib` file when you add/edit references
- Essential for LaTeX integration

**Installation**:
1. Download plugin: https://retorque.re/zotero-better-bibtex/installation/
   - Click "Install" → Download `.xpi` file
2. In Zotero: Tools → Add-ons
3. Click gear icon (⚙️) → "Install Add-on From File..."
4. Select downloaded `.xpi` file
5. Restart Zotero

**Verify Installation**:
- Zotero → Edit → Preferences → Better BibTeX tab should appear

### Step 3: Configure Better BibTeX

**Citation Key Format**:
1. Preferences → Better BibTeX → Citation keys
2. Citation key format: `[auth:lower][year]`
   - Example: Klak et al. 2025 → `klak2025`
   - Smith & Jones 2023 → `smith2023`
3. ✅ Check "On item change" → Auto-regenerate keys

**Auto-Export Settings**:
1. Preferences → Better BibTeX → Automatic export
2. ✅ "On change"
3. Idle time: 5 seconds (waits 5s before exporting)

### Step 4: Create Collection Structure

**In Zotero**:
1. Click "New Collection" (folder icon)
2. Create hierarchy:

```
📁 KANNA Thesis
  📁 Ch01 - Introduction
  📁 Ch02 - Botanique
  📁 Ch03 - Ethnobotanie
  📁 Ch04 - Pharmacologie
  📁 Ch05 - Clinique
  📁 Ch06 - Addiction
  📁 Ch07 - Juridique
  📁 Ch08 - Synthèse
  📁 _ToRead (unread papers)
  📁 _KeyPapers (highly cited, important)
```

### Step 5: Import Existing PDFs

**Import 8 French PDFs from `literature/pdfs/`**:

1. File → Import → Files...
2. Navigate to `/home/miko/LAB/projects/KANNA/literature/pdfs/`
3. Select all 8 PDFs:
   - Analyse des Gaps et Plan de Rédaction.pdf
   - Circuits de l'Addiction.pdf
   - Les Aizoacées.pdf
   - Les Pratiques de Guérison du Peuple San.pdf
   - Neuroinflammation et Troubles Psychiatriques.pdf
   - Plan Extrêmement Ajusté.pdf
   - Processus de fermentation du kanna.pdf
   - comment partager cet espace avec claude agent.pdf
4. Click "Open"
5. Zotero will:
   - Extract metadata (title, authors, year)
   - Create library entries
   - Attach PDFs

**Assign to Collections**:
- Drag each paper to appropriate chapter folder
- Use tags: `french`, `unread`, `ch01`, etc.

### Step 6: Import from Elicit

1. File → Import → Select `elicit-export.ris`
2. Papers import into "Unfiled Items"
3. Review each paper:
   - Assign to chapter collection
   - Add tags: `elicit`, `sceletium`, `pharmacology`, etc.
   - Check if PDF attached (if not, download from DOI)

### Step 7: Configure Auto-Export to `kanna.bib`

**Critical Step for LaTeX Integration**:

1. **Right-click** "KANNA Thesis" collection (root folder)
2. Export Collection...
3. Format: **Better BibLaTeX** (not "Better BibTeX" - use BibLaTeX!)
4. ✅ **Keep Updated** (CRITICAL!)
5. Save to: `/home/miko/LAB/projects/KANNA/literature/zotero-export/kanna.bib`

**Verify Path**:
```bash
ls -lh ~/LAB/projects/KANNA/literature/zotero-export/kanna.bib
# Should show file, size ~5-10 KB after importing 8 papers
```

**Test Auto-Update**:
1. Add a new paper to Zotero (any paper)
2. Wait 5 seconds
3. Check `kanna.bib` modification time:
   ```bash
   stat ~/LAB/projects/KANNA/literature/zotero-export/kanna.bib
   # Modify time should update within 5-10 seconds
   ```

---

## Part C: Obsidian Knowledge Graph

### Step 1: Open Vault

**Obsidian is already installed in LAB workflow** (check `~/LAB/CLAUDE.md`)

1. Open Obsidian
2. "Open folder as vault"
3. Navigate to: `/home/miko/LAB/projects/KANNA/literature/notes/`
4. Click "Open"

### Step 2: Install Essential Plugins

**Navigate to**: Settings (⚙️) → Community Plugins → Turn off Safe Mode → Browse

**Install 5 Plugins**:

#### 1. Zotero Integration
- Search: "Zotero Integration"
- Install + Enable
- **Configure**:
  - Settings → Zotero Integration
  - Zotero Port: `23119` (default)
  - Database: Auto-detect (should find `~/Zotero/zotero.sqlite`)
  - ✅ Import annotations
  - ✅ Import PDF highlights
  - **Template**: Will create in Step 3

#### 2. Dataview
- Search: "Dataview"
- Install + Enable
- **Configure**:
  - Settings → Dataview
  - ✅ Enable JavaScript Queries
  - ✅ Enable Inline Queries

#### 3. Citations
- Search: "Citations"
- Install + Enable
- **Configure**:
  - Settings → Citations
  - Citation database: `/home/miko/LAB/projects/KANNA/literature/zotero-export/kanna.bib`
  - ✅ Auto-reload on change

#### 4. Graph Analysis
- Search: "Graph Analysis"
- Install + Enable
- (No configuration needed)

#### 5. Templater
- Search: "Templater"
- Install + Enable
- **Configure**:
  - Settings → Templater
  - Template folder: `literature/notes/templates/`
  - ✅ Trigger on file creation

### Step 3: Create Note Templates

Create directory:
```bash
mkdir -p ~/LAB/projects/KANNA/literature/notes/templates/
```

#### Template 1: Paper Note (`paper-note.md`)

Create file: `literature/notes/templates/paper-note.md`

```markdown
---
title: "{{title}}"
authors: {{authors}}
year: {{year}}
citekey: {{citekey}}
language: [french/english]
chapter: [ch01-ch08]
status: unread
tags: [#literature, #paper]
---

# {{title}}

## Métadonnées / Metadata

- **Auteurs** : {{authors}}
- **Année** : {{year}}
- **Journal** : {{journal}}
- **DOI** : {{DOI}}
- **Citekey** : `{{citekey}}`

## Résumé en Une Phrase / One-Sentence Summary

{{one-sentence-summary}}

## Points Clés / Key Points

- **Point 1** :
- **Point 2** :
- **Point 3** :

## Pertinence pour la Thèse KANNA / Relevance to KANNA Thesis

**Liens** : [[PDE4-Mechanisms]], [[San-Traditional-Knowledge]], [[Chapitre-04-Pharmacologie]]

**Contributions** :
- Méthode :
- Résultats :
- Discussion :

## Citations Importantes / Important Quotes

> "{{citation}}" (p. {{page}})

**Analyse** : [Pourquoi cette citation est importante]

## Questions pour la Recherche / Research Questions

- [ ] Question 1 :
- [ ] Question 2 :

## Méthodologie Utile / Useful Methodology

[Si applicable: LC-MS protocol, FPIC procedures, statistical methods]

## Références Croisées / Cross-References

- **Cite** : [[Paper-X]], [[Paper-Y]]
- **Cité par** : (Use Zotero to check citations)
- **Concepts liés** : [[Concept-A]], [[Concept-B]]

---

**Date de lecture** : {{date:YYYY-MM-DD}}
**Statut** : {{status}}
```

#### Template 2: Daily Note (`daily-note.md`)

Create file: `literature/notes/templates/daily-note.md`

```markdown
---
date: {{date:YYYY-MM-DD}}
day: {{date:dddd}}
week: W{{date:WW}}
tags: [#daily, #journal]
---

# {{date:YYYY-MM-DD}} - Journal de Recherche

## 📋 Tâches Aujourd'hui / Today's Tasks

- [ ] Lire 3 articles sur [sujet]
- [ ] Rédiger 500 mots pour Chapitre [X]
- [ ] Analyser données [type]
- [ ] Réunion : [détails]

## ✅ Progrès / Progress

### Complété
- ✅ Tâche X

### En cours
- 🔄 Tâche Y (50%)

### Planifié
- 📅 Tâche Z (demain)

## 📚 Littérature Lue / Literature Read

- [[Auteur-Année]] - *Insight principal* : [Résumé en 1 phrase]
- [[Auteur2-Année]] - *Insight* : [Résumé]

## 💻 Code/Analyse / Code & Analysis

**Scripts exécutés** :
- `calculate-bei.R` → BEI = 3.2 ± 0.5
- `qsar-modeling.py` → R² = 0.82

**Problèmes rencontrés** :
- [Issue + solution]

## ✍️ Rédaction / Writing

**Chapitre X, Section Y** : 750 mots rédigés
- **Progrès total** : 15,250 / 120,000 mots (13%)

## 💡 Réflexions / Insights

[Connexions entre concepts, nouvelles questions, idées pour la thèse]

### Liens / Connections
- [[Concept-A]] ← → [[Concept-B]]

## 📅 Demain / Tomorrow

- [ ] Priorité 1 :
- [ ] Priorité 2 :
- [ ] Priorité 3 :

---

**Humeur** : 😊 / 😐 / 😰
**Productivité** : ⭐⭐⭐⭐⭐ (5/5)
```

#### Template 3: Concept Note (`concept-note.md`)

Create file: `literature/notes/templates/concept-note.md`

```markdown
---
title: {{title}}
aliases: [{{alias1}}, {{alias2}}]
tags: [#concept, #{{category}}]
created: {{date:YYYY-MM-DD}}
---

# {{title}}

## Définition / Definition

[Définition claire et concise du concept]

## Contexte KANNA / KANNA Context

**Pertinence** : [Pourquoi ce concept est important pour la thèse]

**Chapitres liés** : [[Ch02-Botanique]], [[Ch04-Pharmacologie]]

## Littérature Clé / Key Literature

- [[Auteur-Année]] - Premier à définir ce concept
- [[Auteur2-Année]] - Extension du modèle
- [[Auteur3-Année]] - Application aux Aizoaceae

## Exemples / Examples

### Sceletium tortuosum
- [Application spécifique au KANNA]

### Autres espèces / Other Species
- [Comparaisons]

## Mécanismes / Mechanisms

[Si concept pharmacologique : PDE4, SERT, etc.]
[Si concept ethnobotanique : FPIC, BEI, ICF]

## Questions Ouvertes / Open Questions

- [ ] Question 1 :
- [ ] Question 2 :

## Références / References

```dataview
TABLE file.ctime as "Date Created", file.tags as "Tags"
FROM [[]]
SORT file.ctime DESC
```

---

**Dernière mise à jour** : {{date:YYYY-MM-DD}}
```

### Step 4: Configure Dataview Queries

**Example Query: Recent Papers Read**

Create file: `literature/notes/Dashboard.md`

```markdown
# KANNA Thesis Dashboard

## 📊 Statistiques / Statistics

```dataview
TABLE
  length(file.lists) as "Tasks",
  length(filter(file.lists, (t) => t.completed)) as "Completed"
FROM #daily
SORT file.ctime DESC
LIMIT 7
```

## 📚 Papers Read This Week

```dataview
TABLE
  authors as "Authors",
  year as "Year",
  chapter as "Chapter",
  status as "Status"
FROM #literature
WHERE status = "reading" OR status = "complete"
SORT file.mtime DESC
LIMIT 10
```

## 🎯 Next to Read

```dataview
TABLE
  authors as "Authors",
  year as "Year",
  chapter as "Chapter"
FROM #literature
WHERE status = "unread"
SORT year DESC
LIMIT 5
```

## 📝 Writing Progress

**Total words**: [Track manually or use word count plugin]

**Chapters**:
- Ch01: 3,500 / 15,000 words (23%)
- Ch02: 0 / 12,000 words (0%)
- etc.
```

### Step 5: First Literature Notes

**Workflow**:
1. Open Zotero
2. Select a paper (e.g., "Circuits de l'Addiction.pdf")
3. Read PDF in Zotero PDF reader
4. Highlight key passages
5. Add comments/annotations

**Import to Obsidian**:
1. Obsidian: Cmd/Ctrl + P (Command Palette)
2. Type: "Zotero Integration: Import"
3. Select paper
4. Obsidian creates note with:
   - Metadata from Zotero
   - Your highlights
   - Your comments
   - PDF link

**Enhance Note**:
1. Add one-sentence summary
2. Identify 3-5 key points
3. Link to relevant concepts: [[PDE4-Inhibition]], [[San-Knowledge]]
4. Add tags: `#ch06`, `#addiction`, `#mechanisms`

**Create 5 Literature Notes** (practice):
- One for each of your 8 French PDFs (choose 5)

---

## Part D: Overleaf Integration

### Step 1: Create Overleaf Project

1. Go to https://www.overleaf.com/
2. Sign up with academic email (@u-paris.fr)
3. Create New Project → Upload Project
4. Search gallery: "PhD Thesis Template U-Paris"
   - Or use generic French thesis template

**Alternative: Custom Template**
If no U-Paris template found:
```latex
\documentclass[12pt,a4paper,twoside]{book}
\usepackage[french]{babel}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{csquotes}
\usepackage[backend=biber,style=nature]{biblatex}

\addbibresource{kanna.bib}

\begin{document}
\title{Sceletium tortuosum : Analyse Interdisciplinaire}
\author{Mickael Souedan}
\date{2025}
\maketitle

\chapter{Introduction}
...

\printbibliography
\end{document}
```

### Step 2: Upload Bibliography

**Option A: Manual Upload** (if Overleaf Free)
1. In Overleaf project: "Upload" button
2. Select `/home/miko/LAB/projects/KANNA/literature/zotero-export/kanna.bib`
3. File appears in project files

**Problem**: Manual re-upload needed when bibliography updates

**Option B: Git Sync** (if Overleaf Premium)
1. Overleaf → Menu → Git
2. Copy Git URL
3. Local:
   ```bash
   cd ~/LAB/projects/KANNA/writing/thesis-overleaf/
   git clone <overleaf-git-url> .
   ln -s ../../literature/zotero-export/kanna.bib kanna.bib
   git add kanna.bib
   git commit -m "Link to auto-updating bibliography"
   git push
   ```

**Recommended for Free Tier**: Upload `kanna.bib` weekly

### Step 3: Configure Bibliography in LaTeX

**In `main.tex`**:
```latex
\documentclass[12pt,a4paper]{book}
\usepackage[french]{babel}
\usepackage[backend=biber,style=nature,sorting=none]{biblatex}

% Point to your bibliography
\addbibresource{kanna.bib}

\begin{document}

\chapter{Introduction}

Les alcaloïdes de \textit{Sceletium tortuosum} présentent
une double inhibition SERT/PDE4 \parencite{klak2025}.

\printbibliography

\end{document}
```

### Step 4: Test Citation Workflow

**Add citation**:
```latex
\parencite{klak2025}  % Parenthetical: (Klak et al., 2025)
\textcite{klak2025}   % Textual: Klak et al. (2025)
\cite{klak2025}       % Inline: Klak et al., 2025
```

**Compile**:
1. Overleaf: Recompile (Cmd/Ctrl + S)
2. PDF should show citation
3. References section should show full citation

**Troubleshooting**:
- Citation appears as `[klak2025]` in bold → Compile again (biber needs 2 passes)
- "Citation undefined" → Check citekey matches `kanna.bib`
- No references section → Add `\printbibliography` before `\end{document}`

---

## Part E: Daily Workflow

### Morning Routine (08:00-10:00): Literature Discovery

**Step 1: Elicit Search** (30 min)
```bash
# Open Elicit
# Query: "Sceletium clinical trials anxiety 2024-2025"
# Export 5-10 new papers to RIS
```

**Step 2: Import to Zotero** (15 min)
```bash
# Zotero: File → Import → Select RIS
# Assign to chapters
# Download PDFs (click DOI link)
# Tag: #toread, #ch05, #clinical
```

**Step 3: Obsidian Daily Note** (15 min)
```bash
# Open Obsidian
# Create daily note (Cmd+N, apply template)
# Plan tasks:
#   - [ ] Read 3 papers on [topic]
#   - [ ] Write 500 words Ch01 Section 1.2
```

### Midday Reading Block (10:00-12:00): Deep Reading

**Step 1: Select Paper** (Zotero)
- Filter: Tag = `#toread`, Sort by Year (DESC)
- Open in Zotero PDF reader

**Step 2: Active Reading**
- Highlight key methods, results, discussion
- Add margin comments: Questions, critiques, connections
- Rate importance: ⭐⭐⭐⭐⭐

**Step 3: Import to Obsidian**
```bash
# Cmd+P: "Zotero Integration: Import"
# Select paper
# Enhance note:
#   - One-sentence summary
#   - Link to concepts: [[SERT-Inhibition]], [[Clinical-Trials]]
#   - Tag: #ch05, #clinical, #complete
```

**Step 4: Update Zotero**
```bash
# Change tag: #toread → #complete
# kanna.bib auto-updates (wait 5 seconds)
```

### Afternoon Synthesis (14:00-16:00): Concept Building

**Step 1: Review Daily Notes**
- Check `Dashboard.md` dataview queries
- Papers read this week: 15
- Concepts created: 8

**Step 2: Create Concept Notes**
If you read 3 papers on "PDE4 inhibition":
```bash
# Create new note: [[PDE4-Inhibition-Mechanisms]]
# Link to 3 paper notes
# Synthesize: What's the consensus?
# Add questions: [ ] Does mesembrenone specificity matter?
```

**Step 3: Update Knowledge Graph**
```bash
# Obsidian: Open Graph View
# Check density: Aim for 5+ links per concept
# Sparse areas = need more reading
```

### Evening Writing (16:00-18:00): Thesis Drafting

**Step 1: Open Overleaf**
```bash
# Navigate to current section (e.g., Ch01 Section 1.2)
```

**Step 2: Consult Obsidian**
```bash
# Open related concept notes
# Copy insights into LaTeX
# Cite with \parencite{citekey}
```

**Step 3: Write 500-1000 Words**
```latex
\section{Biopiraterie du Sceletium tortuosum}

Le monopole Zembrin® illustre les tensions entre
savoirs traditionnels Khoisan et appropriation
scientifique occidentale \parencite{dutfield2023}.

Les brevets HGH Pharmaceuticals (WO2010106495)
présentent des défauts de nouveauté, les usages
traditionnels étant documentés depuis 1662
\parencite{vanriebeeck1662}.
```

**Step 4: Update Daily Note**
```markdown
## ✍️ Rédaction

**Chapitre 1, Section 1.2** : 750 mots rédigés
- **Progrès total** : 3,750 / 15,000 mots Ch01 (25%)
```

### Weekly Review (Dimanche 18:00): Retrospective

**Metrics to Track**:
```markdown
## Semaine du 2025-10-06

### Littérature
- Papers lus : 15
- Concepts créés : 8
- Notes Obsidian : 23 (total 156)

### Rédaction
- Mots écrits : 3,500
- Progrès Ch01 : 25% → 32%

### Analyses
- Scripts R : calculate-bei.R (BEI = 3.2)
- QSAR : R² = 0.78 (pas encore 0.80)

### Blocages
- MAXQDA license? (check U-Paris)
- Need more SERT IC50 data (search Elicit)

### Prochaine Semaine
- [ ] Priorité 1 : Finish Ch01 Section 1.2 (1500 words)
- [ ] Priorité 2 : Improve QSAR R² with Mordred descriptors
- [ ] Priorité 3 : Create FPIC protocol template
```

---

## Troubleshooting

### Issue 1: Better BibTeX Not Auto-Updating

**Symptom**: Add paper to Zotero, but `kanna.bib` doesn't update

**Solution**:
1. Check auto-export is configured:
   - Right-click "KANNA Thesis" collection
   - Export Collection → verify "Keep Updated" is ✅
2. Check Better BibTeX settings:
   - Preferences → Better BibTeX → Automatic export
   - Ensure "On change" is enabled
3. Manual export:
   - Right-click collection → Export Collection
   - Overwrite `kanna.bib`

### Issue 2: Zotero Integration Plugin Not Finding Database

**Symptom**: Obsidian says "Cannot find Zotero database"

**Solution**:
```bash
# Find Zotero data directory
# Linux:
ls ~/.zotero/zotero/
# Mac:
ls ~/Zotero/

# In Obsidian: Settings → Zotero Integration
# Database: /home/miko/.zotero/zotero/<profile>/zotero.sqlite
# Or use auto-detect

# Ensure Zotero is running when importing
```

### Issue 3: Citations Not Rendering in Overleaf

**Symptom**: Citation appears as `[klak2025]` in bold

**Solution**:
1. **Compile twice** (biber needs 2 passes):
   - First compile: Generates `.aux` file
   - Second compile: Resolves citations
2. Check `kanna.bib` uploaded to Overleaf
3. Verify citekey:
   - In Zotero: Select paper → Info → Extra field shows citekey
   - Must match exactly: `\parencite{klak2025}` and `@article{klak2025,`

### Issue 4: Obsidian Dataview Not Working

**Symptom**: Dataview queries show as code blocks

**Solution**:
1. Settings → Dataview → ✅ Enable JavaScript Queries
2. Syntax check:
   ````markdown
   ```dataview
   TABLE authors, year
   FROM #literature
   ```
   ````
3. Restart Obsidian

### Issue 5: Slow Syncing Between Tools

**Symptom**: Add paper in Zotero, doesn't appear in Obsidian search

**Solution**:
- Zotero → Obsidian: Requires manual import (Cmd+P → "Zotero Integration: Import")
- Zotero → `kanna.bib`: Auto within 5 seconds (Better BibTeX)
- `kanna.bib` → Overleaf: Manual upload weekly (if Free tier)

**Workflow Diagram**:
```
Elicit (discover) → RIS export
   ↓
Zotero (import RIS) → Auto-export (5s delay)
   ↓
kanna.bib (auto-update)
   ↓
Overleaf (manual upload weekly if Free)
```

---

## Best Practices

### Literature Organization
- **Immediately tag** papers on import (don't defer)
- **Use collections** hierarchically (by chapter, not flat)
- **Rate importance**: ⭐⭐⭐⭐⭐ for seminal papers
- **Read abstracts first**, full text only if highly relevant

### Obsidian Knowledge Graph
- **Link densely**: Aim for 5-10 links per note
- **Use aliases**: `[[SERT|serotonin transporter]]`
- **Atomic notes**: One concept per note (not 10 concepts in 1 note)
- **Daily notes**: Track progress, don't skip

### Writing Workflow
- **Cite while writing**, not later (easier to track sources)
- **Use natbib/biblatex** shortcuts: `\parencite{}`, `\textcite{}`
- **Compile frequently**: Catch errors early
- **Version control**: Commit to Git weekly

### Time Management
- **Morning**: Discovery (Elicit, high energy)
- **Midday**: Deep reading (focused, no interruptions)
- **Afternoon**: Synthesis (creative connections)
- **Evening**: Writing (output mode)

---

## Next Steps

**Week 1**: Complete this setup
**Week 2**: Process 50 papers (Elicit → Zotero → Obsidian)
**Week 3**: Write first 5,000 words in Overleaf with proper citations
**Week 4**: Refine workflow, optimize for speed

**Goal**: 500+ papers in Zotero, 200+ notes in Obsidian, 15,000 words in Overleaf by Month 2

---

## Further Resources

**Zotero**:
- Official docs: https://www.zotero.org/support/
- Better BibTeX manual: https://retorque.re/zotero-better-bibtex/

**Obsidian**:
- Forum: https://forum.obsidian.md/
- Zettelkasten method: https://zettelkasten.de/

**Overleaf**:
- LaTeX templates: https://www.overleaf.com/latex/templates
- Bibliography guide: https://www.overleaf.com/learn/latex/Bibliography_management_with_biblatex

**Elicit**:
- Help center: https://elicit.com/help

---

**Last Updated**: October 2025
**Next Review**: After 100 papers imported
**Questions**: Document in `tools/guides/FAQ.md`
