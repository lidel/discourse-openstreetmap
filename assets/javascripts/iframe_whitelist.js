(function() {
  if (Discourse.dialect_deprecated) { return; }
  Discourse.Markdown.whiteListIframe(/^(https?:)?\/\/www\.openstreetmap\.org\/export\/embed.html\?.+/i);
})();
