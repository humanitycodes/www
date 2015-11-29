require! {
  '../components/new-issue-form': NewIssueForm
  '../components/post-button': PostButton
}

module.exports = (lesson, user) ->

  const project-folder-name = "codelab-#{ lesson.key }"
  const repo-key = "#{ user.username }/#{ project-folder-name }"
  const repo-URL = "https://github.com/#{ repo-key }"
  const clone-URL = "#{ repo-URL }.git"
  const issues-URL = "#{ repo-URL }/issues"

  const $cd-instructions =
    $li do
      $code 'cd'
      ' into your '
      $code project-folder-name
      " directory (unless you're already there)"
  [
    * title: 'Create a repository on GitHub'
      content: $div do
        $p "Before we can start coding, we need a place to keep our code."
        $p do
          $(PostButton) do
            href: "/repositories?key=#{ lesson.key }"
            type: <[ primary block ]>
            'Create a repository on GitHub'
      octicon: 'repo'
      is-active: !lesson.status?
      is-complete: lesson.status?
      complete-content: $span do
        "You've created a GitHub repository at:"
        $br!
        $code repo-key
      complete-on-click: ->
        window.open repo-URL, '_blank'

    * octicon: 'arrow-down'

    * title: 'Download the repository folder'
      content: $ol do
        $li do
          $code 'cd'
          " into the directory where you're keeping your Code Lab projects (unless you're already there)"
        $li do
          $code do
            'git clone '
            clone-URL
      octicon: 'repo-clone'
      is-active: lesson.status in <[ started submitted ]>
      is-complete: lesson.status is 'approved'

    * title: 'Commit your changes'
      content: $ol do
        $cd-instructions
        $li do
          $code 'git add -A .'
          ' (adds all file modifications, additions, and deletions to the list of changes to be committed'
        $li do
          $code 'git commit -m "a message describing your changes'
          ' (wraps up all currently added (i.e. staged) changes in a commit)'
      octicon: 'git-commit'
      is-active: lesson.status in <[ started submitted ]>
      is-complete: lesson.status is 'approved'

    * title: 'Upload your latest code to GitHub'
      content: $ol do
        $cd-instructions
        $li do
          $code 'git push origin master'
          ' (pushes your latest commits to GitHub - i.e origin)'
      octicon: 'repo-push'
      is-active: lesson.status in <[ started submitted ]>
      is-complete: lesson.status is 'approved'

    * title: 'Publish your website'
      content: $ol do
        $cd-instructions
        if lesson.categories.index-of('ruby') is -1
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
      octicon: 'cloud-upload'
      is-active: lesson.status in <[ started submitted ]>
      is-complete: lesson.status is 'approved'

    * octicon: 'arrow-down'

    * title: 'Get feedback from a mentor'
      content: $div do
        $p do
          'Then '
          $strong do
            "when you've met "
            $a do
              href: '#project-criteria'
              'the project criteria'
          ", request feedback below and we'll help you refine it:"
        $(NewIssueForm) do
          repo-URL: repo-URL
          project: lesson.project
      octicon: 'organization'
      is-active: lesson.status in <[ started ]>
      is-complete: lesson.status in <[ submitted approved ]>
      complete-content: do
        if lesson.status is 'submitted'
          "Great job submitting your work for review! A mentor will take a look and give you feedback until it's shipit-worthy. If changes to your code are necessary, you'll want to repeat the previous set of steps for each change."
        else
          "You submitted your work and it's been approved. Congratulations!"
      complete-on-click: ->
        window.open issues-URL, '_blank'

    * octicon: 'arrow-down'

    * title: "Ensure mastery"
      content: $div do
        $p do
          "Before you move on to a subsequent lesson, we'll use the same quality assurance process as professional developers: the code review. A mentor will look over your work, you might refine it a bit more, then when it looks like you've fully mastered this skill, they'll leave you "
          $a do
            target: '_blank'
            href: 'https://www.quora.com/GitHub/What-is-the-significance-of-the-Ship-It-squirrel'
            'the "shipit" squirrel'
          " in a comment."
        $p do
          "In the meantime, you can keep collaborating with mentors through "
          $a do
            target: '_blank'
            href: issues-URL
            "opened issues for your repository"
          "."
      octicon: 'squirrel'
      is-active: lesson.status is 'submitted'
      is-complete: lesson.status is 'approved'
  ]
