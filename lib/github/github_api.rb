require 'json'
require 'open-uri'

module Github
  class GithubAPI
    API_URL = 'https://api.github.com/users'

    def self.user(login)
      url = API_URL + "/#{login}" if login
      JSON.parse(open(url).read) if url
    end

    def self.repositories(current_user)
      if current_user.repos_url.empty?
        url = API_URL + "/#{current_user.login}/repos" if current_user.login
        JSON.parse(open(url).read) if url
      else
        JSON.parse(open(current_user.repos_url).read)
      end
    end

  end
end