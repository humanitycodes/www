class Lesson
  LESSONS_WATCHER = LessonsWatcher.new

  class << self

    def all user, options={}
      if user.nil?
        return LESSONS_WATCHER.lessons.map { |lesson_hash| Lesson.new lesson_hash }
      end

      lessons_key = "Lesson.all #{user.id}"
      cached_lessons = Rails.cache.read(lessons_key)

      if cached_lessons && options[:from_cache]
        return cached_lessons
      end

      Rails.cache.fetch(lessons_key, expires_in: 1.hour) do
        LESSONS_WATCHER.lessons.map do |lesson_hash|
          Lesson.new lesson_hash, user_dictionary(user)
        end
      end
    end

    def where requirements, user, options={}
      Rails.cache.fetch("Lesson.where #{requirements}, #{user && user.id}", force: !user || !options[:from_cache]) do
        lesson_hashes = LESSONS_WATCHER.lessons.select do |lesson_hash|
          requirements.all? { |attribute, value| lesson_hash[attribute] == value }
        end
        lesson_keys = lessons.map { |lesson| lesson[:key] } if user
        lesson_hashes.map do |lesson_hash|
          Lesson.new lesson_hash, user_dictionary(user, lesson_keys)
        end
      end
    end

    def find key, user, options={}
      Rails.cache.fetch("Lesson.find #{key}, #{user && user.id}", force: !user || !options[:from_cache]) do
        lesson_hash = LESSONS_WATCHER.lessons.find do |lesson_hash|
          lesson_hash[:key] == key
        end
        return unless lesson_hash
        Lesson.new lesson_hash, user_dictionary(user, [key])
      end
    end

  private

    def user_dictionary user, keys=nil
      user && LessonsStatusFetcher.new(user, keys).dictionary
    end

  end

  def initialize lesson_hash, status_dictionary=nil
    lesson_hash.each do |attribute, value|
      instance_variable_set("@#{attribute}", value)
      Lesson.class_eval { attr_reader attribute.to_sym }
    end
    if status_dictionary
      Lesson.class_eval { attr_reader :status }
      @status = status_dictionary[@key]
    end
  end

end
