if document?

  require! { '../../../config/codelab_staff.yml': staff }

else

  require! {
    'js-yaml': YAML
    'fs': FS
    'path': Path
  }

  staff = YAML.load FS.read-file-sync do
    Path.join __dirname, '../../../config/codelab_staff.yml'
    'utf8'

module.exports = staff
  |> filter ->
    it.roles |> any (is 'Mentor')
  |> map ->
    it.username = it.contact_methods
      |> find (.type is 'GitHub')
      |> (.body)
    it
