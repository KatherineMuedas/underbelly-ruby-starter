module Underbelly
  class User
    attr_accessor :id, :name, :username, :html_url, :avatar_url, :bio, :location, :links, :buckets_count, :comments_received_count, :followers_count, :followings_count, :likes_count, :likes_received_count, :projects_count, :rebounds_received_count, :shots_count, :teams_count, :can_upload_shot, :type, :pro, :buckets_url, :followers_url, :following_url, :likes_url, :shots_url, :teams_url, :created_at, :updated_at
    
    #finds a team and returns a search object with a user object
    def self.find(username_or_id, options={})
      Underbelly::Search.new("/users/#{username_or_id}", options)
    end
    
    #replace all the spaces with nothing and separate teams by commas
    def self.multi_find(usernames_or_ids, options={})
      usernames_or_ids.gsub(" ","").split(',').map do |user_name|
        find(user_name).user
      end.compact
    end
    
    #Set the attributes for the object from the search result
    def initialize(values)
      values.each do |attribute_name, attribute_value|
        #transform the key of the hash(attribute_name) into an instances variable and sets the value(attribute_value)
        #same as 
        # @id = values["id"]
        self.instance_variable_set("@#{attribute_name}", attribute_value)
      end    
    end

    #Outputs a list of team names and followers counts sorted by followers counts
    def self.print_names_and_followers(usernames_or_ids, options={})
      sorted_users = sort_by_follower_count(multi_find(usernames_or_ids, options))
      File.open("output.txt", "w+") do |file|
        sorted_users.map do |user|
          file.puts("#{user.name} - #{user.followers_count}")
        end
      end
    end

    # used to sort a array of user objects by follower_count
    def self.sort_by_follower_count(users)
      users.sort_by { |user| user.followers_count }.reverse
    end

  end
end