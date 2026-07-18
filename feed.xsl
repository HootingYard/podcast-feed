<?xml version="1.0" encoding="UTF-8"?>
<!--
  Browser-friendly rendering for the Hooting Yard podcast RSS feed.
  Podcast apps ignore this stylesheet and parse the XML directly; browsers
  apply it (via the xml-stylesheet PI in feed.xml) to show a readable page.
-->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd">
  <xsl:output method="html" encoding="UTF-8" indent="no"
      doctype-system="about:legacy-compat"/>

  <xsl:template match="/rss/channel">
    <html lang="en">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title><xsl:value-of select="title"/></title>
        <style>
          :root { --red:#e60000; --bg:#faf8f5; --card:#ffffff; --ink:#1a1a1a; --muted:#6b6b6b; --line:#e7e2da; }
          @media (prefers-color-scheme: dark) {
            :root { --bg:#141210; --card:#1e1b18; --ink:#f0ece6; --muted:#a89f95; --line:#332e29; }
          }
          * { box-sizing:border-box; }
          body { margin:0; background:var(--bg); color:var(--ink);
            font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,Helvetica,Arial,sans-serif;
            line-height:1.5; }
          .wrap { max-width:820px; margin:0 auto; padding:24px 18px 64px; }
          header { display:flex; gap:20px; align-items:flex-start; flex-wrap:wrap;
            border-bottom:3px solid var(--red); padding-bottom:24px; }
          header img { width:150px; height:150px; border-radius:10px; flex:none;
            box-shadow:0 2px 10px rgba(0,0,0,.15); }
          h1 { margin:0 0 8px; font-size:1.9rem; }
          .lede { color:var(--muted); margin:0 0 12px; }
          .count { display:inline-block; background:var(--red); color:#fff; font-weight:600;
            font-size:.8rem; padding:3px 10px; border-radius:999px; }
          .banner { font-size:.8rem; color:var(--muted); margin:16px 0 22px; padding:10px 14px;
            background:var(--card); border:1px solid var(--line); border-radius:8px; }
          article { background:var(--card); border:1px solid var(--line); border-radius:10px;
            padding:16px 18px; margin:14px 0; }
          h2 { margin:0 0 4px; font-size:1.15rem; }
          .meta { color:var(--muted); font-size:.82rem; margin:0 0 12px; }
          audio { width:100%; height:38px; }
          details { margin-top:12px; }
          summary { cursor:pointer; color:var(--red); font-weight:600; font-size:.85rem; }
          .notes { white-space:pre-wrap; font-size:.86rem; margin-top:10px; padding-top:10px;
            border-top:1px solid var(--line); }
          .notes a { color:var(--red); }
          footer { color:var(--muted); font-size:.8rem; text-align:center; margin-top:40px; }
          footer a { color:var(--red); }
        </style>
      </head>
      <body>
        <div class="wrap">
          <header>
            <img src="{itunes:image/@href}" alt="{title}"/>
            <div>
              <h1><xsl:value-of select="title"/></h1>
              <p class="lede"><xsl:value-of select="description"/></p>
              <span class="count"><xsl:value-of select="count(item)"/> episodes</span>
            </div>
          </header>
          <p class="banner">This is a podcast feed. Paste this page's URL into a podcast app
            (Apple Podcasts, Spotify, YouTube and others) to subscribe. Audio streams from the
            Internet Archive.</p>
          <xsl:for-each select="item">
            <article>
              <h2><xsl:value-of select="title"/></h2>
              <p class="meta">
                <xsl:value-of select="substring(pubDate,1,16)"/>
                <xsl:if test="itunes:duration"> &#183; <xsl:value-of select="itunes:duration"/></xsl:if>
              </p>
              <audio controls="controls" preload="none" src="{enclosure/@url}"></audio>
              <details>
                <summary>Show notes</summary>
                <div class="notes"><xsl:value-of select="description"/></div>
              </details>
            </article>
          </xsl:for-each>
          <footer>
            <p><xsl:value-of select="copyright"/></p>
            <p><a href="{link}"><xsl:value-of select="link"/></a></p>
          </footer>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
