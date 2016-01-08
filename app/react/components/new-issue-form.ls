module.exports = Radium class NewIssueForm extends React.Component
  (props) !->
    super props

    @styles =
      inline-text:
        base:
          padding: '0 5px'
        first:
          padding: '0 5px 0 0'

  open-new-issue: (event) !~>
    event.prevent-default!

    const jq-project-criteria = jQuery('#project-criteria')

    const all-criteria-are-checked = ->
      jq-project-criteria
        .find 'input[type="checkbox"]'
        .to-array! |> all (.checked)

    if all-criteria-are-checked!

      const mentor = @refs.mentor.value

      hosted-URL = @refs.hosted-URL.value
      unless /^http/.test hosted-URL
        hosted-URL = 'http://' + hosted-URL

      const new-issue-URL = """
        #{ @props.repo-URL }/issues/new?#{
          jQuery.param do
            title: 'Code Lab Feedback'
            body: "Hey @#{mentor}, can you take a look at this? It's [hosted here](#{hosted-URL}) and meets the following [project](http://lansingcodelab.com/lessons/#{@props.repo-URL.split('codelab-')[1]}/1) criteria:\n\n- [x] #{@props.project.criteria.join('\n- [x] ')}"
        }
      """

      jQuery('body').trigger 'click' # Closes form popover

      window.open( new-issue-URL, '_blank' ).focus!

      jQuery(window).one 'focus', @props.on-refetch-lesson

    else

      jq-html-and-body = jQuery('html,body')
      jq-project-cell = jQuery('#project-cell')

      if jq-project-cell.has-class 'collapsed'
        jq-project-cell.trigger 'click'
      else
        jq-html-and-body.trigger 'click'

      set-timeout do
        !->
          jq-html-and-body.animate do
            scrollTop: jq-project-criteria.offset!.top
          .promise!.done !->
            alert("Please make sure your work meets the project criteria before submitting. As you do, check each checkbox. Then you can submit your work for feedback.")
        500

  render: ->

    $form do
      class-name: 'well'
      on-submit: @open-new-issue

      $p do
        $span do
          style:
            * @styles.inline-text.base
            * @styles.inline-text.first
          'Hey'
        $select do
          ref: 'mentor'
          name: 'mentor'
          CONFIG.mentors
            |> shuffle
            |> map (mentor) ->
              $option do
                key: mentor.username
                value: mentor.username
                mentor.name
        ', '
        $span do
          style: @styles.inline-text.base
          "can you take a look at this? It's hosted at:"

      $div class-name: 'form-group',
        $input do
          ref: 'hostedURL'
          type: 'text'
          class-name: 'form-control'
          placeholder: "What's the link for your website?"

      $button do
        type: 'submit'
        class-name: 'btn btn-primary btn-block'
        style: @props.style
        'Ask for feedback'
