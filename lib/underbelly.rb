require 'dotenv'
Dotenv.load

require_relative './underbelly/search.rb'
require_relative './underbelly/user.rb'

module Underbelly
  BASE_URL = "https://api.dribbble.com/v1"
  DEFAULT_PARAMS = {access_token: ENV['ACCESS_TOKEN']}
end
