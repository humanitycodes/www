class Lesson
  LESSONS_WATCHER = LessonsWatcher.new

  MARKDOWN_SEARCH_RENDERER = Redcarpet::Markdown.new(
    Redcarpet::Render::HTML.new(
      no_images: true,
      no_styles: true,
      link_attributes: {
        target: '_blank'
      }
    ),
    autolink: true,
    tables: true
  )

  class << self

    def all user, options={}
      lessons_key = "Lesson.all #{user && user.id}"
      Rails.cache.fetch(lessons_key, expires_in: 1.hour, force: !user || options[:force_refresh]) do
        dictionary = user_dictionary(user)
        LESSONS_WATCHER.lessons.map do |lesson_hash|
          Lesson.new lesson_hash, dictionary
        end
      end
    end

    def where requirements, user, options={}
      Rails.cache.fetch("Lesson.where #{requirements}, #{user && user.id}", force: !user || options[:force_refresh]) do
        lesson_hashes = LESSONS_WATCHER.lessons.select do |lesson_hash|
          requirements.all? { |attribute, value| lesson_hash[attribute] == value }
        end
        lesson_keys = lessons.map { |lesson| lesson[:key] } if user
        dictionary = user_dictionary(user, lesson_keys)
        lesson_hashes.map do |lesson_hash|
          Lesson.new lesson_hash, dictionary
        end
      end
    end

    def find key, user, options={}
      Rails.cache.fetch("Lesson.find #{key}, #{user && user.id}", force: !user || options[:force_refresh]) do
        lesson_hash = LESSONS_WATCHER.lessons.find do |lesson_hash|
          lesson_hash[:key] == key
        end
        return unless lesson_hash
        Lesson.new lesson_hash, user_dictionary(user, key)
      end
    end

    def search query, user, options={}
      return [] if query.blank? || !(query =~ /\A\p{L}+[\p{Word}\p{Space}\p{Punct}]*\z/)
      Lesson.all(user, options).sort_by do |lesson|
        lesson.project['status'].nil? ? 1 : 0
      end.map do |lesson|
        lesson.pages.select do |page|
          query.split(/\s/).all? do |query_word|
            query_matcher = /^.*?\b(#{query_word})\b.*?$/i
            if match = page.content.match(query_matcher)
              page.matches ||= []
              render_match = MARKDOWN_SEARCH_RENDERER.
                render(match[0]).
                gsub(/\b#{match[1]}\b/, "<mark>#{match[1]}</mark>").
                gsub(/\A(?:\s*<.+?>\s*){3}(.+)(?:\s*<\/\w+>\s*){3}\Z/, '\1').
                gsub(/\A(?:\s*<.+?>\s*){2}(.+)(?:\s*<\/\w+>\s*){2}\Z/, '\1').
                gsub(/\A(?:\s*<.+?>\s*){1}(.+)(?:\s*<\/\w+>\s*){1}\Z/, '\1')
              strip_regex = /(?:<|&lt;)\/?mark(?:>|&gt;)/
              match_already_added = page.matches.any? do |existing_match|
                existing_match.gsub(strip_regex, '') == render_match.gsub(strip_regex, '')
              end
              if match_already_added
                page.matches = page.matches.map do |existing_match|
                  if Nokogiri::HTML(existing_match).text =~ /#{match[1]}/
                    existing_match.gsub(/\b#{match[1]}\b/, "<mark>#{match[1]}</mark>")
                  else
                    existing_match
                  end
                end
              else
                if Nokogiri::HTML(render_match).text =~ /#{match[1]}/
                  page.matches << render_match
                end
              end
            end
            match
          end
        end.map do |page|
          page.lesson = lesson
          page.title = MARKDOWN_SEARCH_RENDERER.render(page.title).gsub(/\A<p>(.+)<\/p>\Z/, '\1')
          page.url = "/lessons/#{lesson.key}/#{page.number}"
          arst if page.matches.any? { |match| match.blank? }
          page
        end
      end.flatten.compact.group_by(&:lesson)
    end

  private

    def user_dictionary user, keys=nil
      user && LessonsProjectsFetcher.new(user, keys: keys).dictionary
    end

  end

  attr_reader :title, :categories, :prereqs, :project, :key, :slides

  def initialize lesson_hash, project_dictionary=nil
    lesson_hash.each do |attribute, value|
      instance_variable_set("@#{attribute}", value)
    end
    if project_dictionary && project_dictionary[@key]
      @project.merge! project_dictionary[@key]
    end
  end

  def pages
    @pages ||= @slides.split("\n---\n").each_with_index.map do |page, index|
      page_parsing = page.match(/##\s+(.+?)\n+(.+)\z/m)
      page_title = page_parsing[1]
      page_content = page_parsing[2]

      OpenStruct.new({
        title: page_title,
        content: page_content,
        number: index + 1
      })
    end
  end

end
