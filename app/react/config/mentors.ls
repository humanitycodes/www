if process.env.NODE_ENV is 'test'

  # Can't require webpack loaders through jest,
  # because jest doesn't play well with webpack.

  require! {
    'js-yaml': YAML
    'fs': FS
    'path': Path
  }

  staff = YAML.load FS.read-file-sync do
    Path.join __dirname, '../../../config/codelab_staff.yml'
    'utf8'

else

  require! { '../../../config/codelab_staff.yml': staff }

module.exports = staff
  |> filter ->
    it.roles |> any (is 'Mentor')
  |> map ->
    it.username = it.contact_methods
      |> find (.type is 'GitHub')
      |> (.body)
    it
