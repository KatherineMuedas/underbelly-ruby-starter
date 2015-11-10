require 'httparty'

module Underbelly
  class Search

    attr_accessor :status, :message, :user

    def initialize(path, options = {})
      # Combines the base url with a path
      search_url = Underbelly::BASE_URL + path
      search(search_url, options)
    end

    # Calls the Api based on the search url
    # Search method for all GET requests. It needs a search_url param which comes from the initializer 
    # and a options hash param which could be use to send in additional query params to the search.
    def search (search_url, options = {})
      # HttParty encapsulate Net::Http library to make it more developer friendly. 
      # It is making a get request to the search_url. 
      # Sets options to the query and merges the default params. Example the access_token.
      http_response = HTTParty.get(search_url, query: options.merge(Underbelly::DEFAULT_PARAMS))
      # HttParty has methods like .parsed_response, .body, .code, .message, .headers.inspect
      # Set @status equal to the code that is returning we can uses this to make sure that the response was successful.
      @status = http_response.code
      # Message is set to get more detail of the status. It is more useful when the response is not successful.
      @message = http_response.message
      # Before set the response to the User object, it makes sure that the response is successful. 
      if status == 200
        # Set a local variable equal to the parsed response. 
        # The parsed_response method calls JSON parse without explicitly using the JSON library.
        # Return a ruby hash instead of a Json response.
        response = http_response.parsed_response
        # Transform the response into an object in this case a User object.
        # This way it calls the attributes like normal attributes ".name" instead of "['name']".
        # Also allows us to be able to create addition methods for the User object to manipulate the data. 
        @user = Underbelly::User.new(response) 
      end 
    end

  end
end
