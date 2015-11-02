module.exports = class LessonProjectSubmissionInstructions extends React.Component
  render: ->
    $ol do
      $li do
        $code 'cd'
        ' into your '
        $code @props.project-folder-name
        " directory (unless you're already there)"
      $li do
        $code 'git add -A .'
        ' (adds all file modifications, additions, and deletions to the list of changes to be committed'
      $li do
        $code 'git commit -m "a message describing your changes"' ' (wraps up all currently added (i.e. staged) changes in a commit)'
      $li do
        $code 'git push origin master'
        ' (pushes your latest commits to GitHub - i.e origin)'

      if @props.categories.index-of('ruby') is -1

        $li do
          $code 'surge'
          " (to make your website live on the Internet - alternatively, if you don't want to push to a random URL, "
          $code 'surge --domain SPECIFIC-SUBDOMAIN.surge.sh'
          ' will push to a specific URL)'

      else

        $li do
          $code 'heroku create'
          " (unless you've already created a Heroku app for this project), then "
          $code 'git push heroku master'
          ' (to make your website live on the Internet)'
