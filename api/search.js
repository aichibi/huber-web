export default async function handler(req, res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  const q = req.query.q;
  if (!q) return res.status(400).json({ error: 'missing q' });
  try {
    const r = await fetch('https://api.duckduckgo.com/?q=' + encodeURIComponent(q) + '&format=json&no_html=1&skip_disambig=1');
    const d = await r.json();
    let result = '';
    if (d.AbstractText) result += d.AbstractText + ' ';
    if (d.AbstractURL) result += '(来源: ' + d.AbstractURL + ') ';
    if (d.RelatedTopics) d.RelatedTopics.slice(0, 5).forEach(function(t) { if (t.Text) result += t.Text + ' '; });
    res.json({ result: result.trim() || '未找到相关信息' });
  } catch(e) {
    res.json({ result: '搜索失败' });
  }
}
