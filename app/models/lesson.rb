class Lesson
  LESSONS_WATCHER = LessonsWatcher.new

  def self.all user=nil
    Rails.cache.fetch("Lesson.all #{user && user.id}", expires_in: 1.hour, force: true) do
      LESSONS_WATCHER.lessons.map do |lesson_hash|
        Lesson.new lesson_hash, user && LessonsStatusFetcher.new(user).dictionary
      end
    end
  end

  def self.where(requirements, user=nil)
    Rails.cache.fetch("Lesson.where #{requirements}, #{user && user.id}", expires_in: 1.hour, force: true) do
      lesson_hashes = LESSONS_WATCHER.lessons.select do |lesson_hash|
        requirements.all? { |attribute, value| lesson_hash[attribute] == value }
      end
      lesson_keys = lessons.map { |lesson| lesson[:key] } if user
      lesson_hashes.map do |lesson_hash|
        Lesson.new lesson_hash, user && LessonsStatusFetcher.new(user, lesson_keys).dictionary
      end
    end
  end

  def self.find key, user=nil
    Rails.cache.fetch("Lesson.find #{key}, #{user && user.id}", expires_in: 1.hour, force: true) do
      lesson_hash = LESSONS_WATCHER.lessons.find do |lesson_hash|
        lesson_hash[:key] == key
      end
      return unless lesson_hash
      Lesson.new lesson_hash, user && LessonsStatusFetcher.new(user, [key]).dictionary
    end
  end

  def initialize lesson_hash, status_dictionary
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
