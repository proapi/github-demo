require 'json'
require 'open-uri'

module Github
  class API
    BASE_URL = 'https://api.github.com/users/'

    def self.repositories(user)
      url = BASE_URL + "/#{user}/repositories/"
      JSON.parse(open(url))
    end

  end
end