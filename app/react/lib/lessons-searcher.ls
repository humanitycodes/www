module.exports = class LessonsSearcher

  (@current-title) !->
    @lessons = []
    jQuery.get-JSON '/lessons.json', (data) !~>
      @lessons = data.lessons

  search: (query) ->
    @lessons
      |> filter (lesson) ~>
        return false if lesson.title is @current-title
        title-match-found = query.split(/\s/) |> all (query-word) ->
          lesson.title.to-lower-case!.search(query-word.to-lower-case!) is not -1
        key-match-found = lesson.key.to-lower-case!.search(query.to-lower-case!) is not -1
        title-match-found or key-match-found
      |> take 5

  set-current-title: (new-title) !->
    @current-title = new-title
