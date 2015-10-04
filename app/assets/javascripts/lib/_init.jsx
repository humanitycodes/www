//= require ../vendor/marked

const CodeLab = {
  config: {},
  helpers: {}
};

(() => {
  const renderer = new marked.Renderer()

  renderer.link = (href, title, text) => {
    return `<a href="${href}" title="${title || ''}" target="_blank">${text}</a>`
  }

  CodeLab.helpers.parseMarkdown = (markdown, options={}) => {
    let html = marked(markdown, {renderer: renderer})

    if (options.unwrap) {
      html = html.replace(/<p>|<\/p>/gi, '')
    }

    return html
  }
})()
