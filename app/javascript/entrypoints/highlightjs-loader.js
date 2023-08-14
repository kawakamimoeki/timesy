import hljs from 'highlight.js';

hljs.highlightAll();
hljs.configure({
  ignoreUnescapedHTML: true,
  throwUnescapedHTML: false,
})
const hmo = new MutationObserver(() => {
  hljs.highlightAll();
  hljs.configure({
    ignoreUnescapedHTML: true,
    throwUnescapedHTML: false,
  })
})
hmo.observe(document.documentElement, { childList: true });
document.documentElement.addEventListener('turbo:frame-render', () => {
  hljs.highlightAll();
  hljs.configure({
    ignoreUnescapedHTML: true,
    throwUnescapedHTML: false,
  })
})
