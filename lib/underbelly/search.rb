require 'httparty'
module Underbelly
  class Search
    attr_accessor :status, :response, :message, :user
    def initialize(path, options = {})
      search_url = Underbelly::BASE_URL + path
      search(search_url, options)
    end
    def search (search_url, options = {})
      http_response = HTTParty.get(search_url, {query: options.merge(Underbelly::DEFAULT_PARAMS)})
      @status = http_response.code
      @message = http_response.message
      response = http_response.parsed_response
      @user = Underbelly::User.new(response)
    end
  end
end