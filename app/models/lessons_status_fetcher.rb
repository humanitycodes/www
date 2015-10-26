class LessonsStatusFetcher
  FETCHER_BASE_URL = 'http://localhost:8080/lesson-repos/'

  def initialize user, keys=nil
    @user = user
    @keys = keys || Lesson.all(nil).map(&:key)
  end

  def dictionary
    @user.lesson_statuses ||= {}
    @user.lesson_statuses = @user.lesson_statuses.merge(fetch['lessons'])
    @user.save
    @user.lesson_statuses
  end

private

  def fetch
    @fetch ||= JSON.parse RestClient.get(
      fetcher_url +
        "?keys=#{@keys.reject{|k| completed_lesson_keys.include?(k)}.join(',')}"
    )
  end

  def completed_lesson_keys
    @user.lesson_statuses ?
      @user.lesson_statuses.select{|k,v| v == 'approved'}.keys
      : []
  end

  def fetcher_url
    @fetcher_url ||= FETCHER_BASE_URL + token
  end

  def token
    @token ||= @user.github_token
  end

end
