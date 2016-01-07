class LessonsProjectsFetcher
  FETCHER_BASE_URL = 'http://localhost:4000/projects/'

  def initialize user, keys: nil, force: false
    @user = user
    @keys = Array( keys || Lesson.all(nil).map(&:key) )
  end

  def dictionary
    @user.projects.merge!(fetch['lessons'])
    @user.save
    @user.projects
  end

private

  def fetch
    @fetch ||= JSON.parse RestClient.get(
      fetcher_url +
        "?only=#{keys_to_fetch.join(',')}"
    )
  end

  def keys_to_fetch
    return @keys if @force_refresh
    @keys.reject do |key|
      completed_project_keys.include? key
    end
  end

  def completed_project_keys
    @user.projects.select do |key, data|
      data['status'] == 'approved'
    end.keys
  end

  def fetcher_url
    FETCHER_BASE_URL + token
  end

  def token
    @user.github_token
  end

end
