require 'yaml'

class LessonsWatcher

  def initialize
    @lessons = get_lessons
    @reloader = ActiveSupport::FileUpdateChecker.new(Dir[ File.dirname(__FILE__) + '/lessons/**/*' ]) do
      @lessons = get_lessons
    end
  end

  def lessons
    @reloader.execute_if_updated
    @lessons
  end

private

  def get_lessons
    Dir[ File.dirname(__FILE__) + '/lessons/*.yml' ].map do |file|
      lesson = YAML.load_file(file).symbolize_keys
      next if lesson[:draft]
      lesson = lesson.merge({
        key: filename_without_extension = File.basename( file, '.*' ),
        slides: File.read( File.dirname(__FILE__) + '/lessons/slides/' + filename_without_extension + '.md' ),
        categories: lesson[:categories] || [],
        prereqs: lesson[:prereqs] || []
      })
    end.compact
  end
end
