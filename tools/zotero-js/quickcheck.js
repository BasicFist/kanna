// Minimal Zotero API quickcheck using Node fetch (no external deps)
// Reports saved searches present and item counts by common tags

const LIB_TYPE = process.env.ZOTERO_LIBRARY_TYPE || 'user'
const LIB_ID = process.env.ZOTERO_LIBRARY_ID
const API_KEY = process.env.ZOTERO_API_KEY

if (!LIB_ID || !API_KEY) {
  console.error('Missing ZOTERO_LIBRARY_ID or ZOTERO_API_KEY')
  process.exit(1)
}

const BASE = `https://api.zotero.org/${LIB_TYPE}s/${LIB_ID}`

async function getJson(url) {
  const resp = await fetch(url, {
    headers: { 'Zotero-API-Key': API_KEY, 'Accept': 'application/json' },
  })
  if (!resp.ok) throw new Error(`${resp.status} ${resp.statusText}`)
  return await resp.json()
}

async function getCount(url) {
  const resp = await fetch(url + '&limit=1', {
    headers: { 'Zotero-API-Key': API_KEY, 'Accept': 'application/json' },
  })
  if (!resp.ok) throw new Error(`${resp.status} ${resp.statusText}`)
  const total = resp.headers.get('Total-Results') || resp.headers.get('total-results')
  return total ? parseInt(total, 10) : NaN
}

async function main() {
  console.log('=== Zotero Quickcheck ===')
  // Saved searches
  const searches = await getJson(`${BASE}/searches?format=json`)
  const names = new Set((searches || []).map(s => s?.data?.name))
  const needed = [
    'KANNA: Untriaged',
    'KANNA: PDE4',
    'KANNA: Mesembrine',
    'KANNA: Year 2020',
  ]
  for (const n of needed) {
    console.log(`Saved search: ${n} -> ${names.has(n) ? 'present' : 'missing'}`)
  }

  // Item counts by tag
  const tags = [
    'project:KANNA',
    'status:untriaged',
    'concept:PDE4',
    'alkaloid:mesembrine',
    'year:2020',
  ]
  for (const t of tags) {
    const count = await getCount(`${BASE}/items?tag=${encodeURIComponent(t)}&format=json`)
    console.log(`Items with tag [${t}]: ${isNaN(count) ? 'n/a' : count}`)
  }
}

main().catch(e => { console.error('Quickcheck failed:', e); process.exit(1) })

