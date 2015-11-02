require! {
  'marked': marked
}

module.exports =

  shuffle: (array) ->
    array `zip-all` [Math.random! for _ to array.length]
      |> sort-by (([_, r]) -> r)
      |> map ([v, _]) -> v

  parse-markdown: (markdown, options={}) ->
    const renderer = new marked.Renderer()

    renderer.link = (href, title, text) ->
      """ <a href="#{href}" title="#{title || ''}" target="_blank">#{text}</a> """

    html = marked markdown, renderer: renderer

    if options.unwrap
      html = html.replace /<p>|<\/p>/gi, ''

    html
