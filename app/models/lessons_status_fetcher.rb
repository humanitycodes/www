class LessonsStatusFetcher
  FETCHER_BASE_URL = 'http://localhost:8080/lesson-repos/'

  def initialize user, keys=nil
    @user = user
    @keys = keys
  end

  def dictionary
    fetch['lessons']
  end

private

  def fetch
    @fetch ||= JSON.parse RestClient.get(fetcher_url + (@keys && "?keys=#{@keys.join(',')}").to_s)
  end

  def fetcher_url
    @fetcher_url ||= FETCHER_BASE_URL + token
  end

  def token
    @token ||= @user.github_token
  end

end
