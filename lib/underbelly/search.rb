require 'httparty'
module Underbelly
  class Search
    attr_accessor :status, :response, :message, :user
    def initialize(path, options = {})
      search_url = Underbelly::BASE_URL + path
      search(search_url, options)
    end

    #Calls the Api based on the search url
    def search (search_url, options = {})
      http_response = HTTParty.get(search_url, {query: options.merge(Underbelly::DEFAULT_PARAMS)})
      @status = http_response.code
      @message = http_response.message
      if status == 200
        response = http_response.parsed_response
        #Transform the Api response into an object
        @user = Underbelly::User.new(response) 
      end
    end
  end
end