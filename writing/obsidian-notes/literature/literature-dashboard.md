---
title: Literature Dashboard
tags: [literature, dashboard, project:KANNA]
---

# Literature Dashboard

## Items by Year
```dataview
TABLE count(rows) AS "Count"
FROM "writing/obsidian-notes/literature"
WHERE contains(tags, "project:KANNA")
GROUP BY year
SORT group DESC
```

## Untriaged Items
```dataview
LIST
FROM "writing/obsidian-notes/literature"
WHERE contains(tags, "status:untriaged")
SORT file.name ASC
```

## Chemistry Focus (PDE4 / SERT / Alkaloids)
```dataview
TABLE year, doi, url
FROM "writing/obsidian-notes/literature"
WHERE contains(file.content, "PDE4") OR contains(file.content, "SERT") OR any(map(t => startswith(t, "alkaloid:"), tags))
SORT year DESC
```

## Recent Notes
```dataview
LIST
FROM "writing/obsidian-notes/literature"
SORT file.mtime DESC
LIMIT 20
```

