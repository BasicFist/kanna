.PHONY: zotero-audit zotero-maintenance zotero-quickcheck install-plugins

zotero-audit:
	python analysis/python/audit_zotero_metadata.py --output tools/reports/zotero-metadata-audit.json --csv tools/reports/zotero-metadata-audit.csv --md tools/reports/zotero-metadata-audit.md
	python analysis/python/attachment_issues_report.py

zotero-maintenance:
	python analysis/python/create_zotero_saved_searches.py
	python analysis/python/align_zotero_tags.py
	python analysis/python/enrich_missing_doi_by_title.py
	python analysis/python/enrich_zotero_by_doi.py
	$(MAKE) zotero-audit

zotero-quickcheck:
	node tools/zotero-js/quickcheck.js | tee quickcheck.log

install-plugins:
	bash tools/scripts/install-zotero-plugins.sh

