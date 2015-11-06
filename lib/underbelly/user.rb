module Underbelly
  class User
    attr_accessor :users, :id, :name, :username, :html_url, :avatar_url, :bio, :location, :links, :buckets_count, :comments_received_count, :followers_count, :followings_count, :likes_count, :likes_received_count, :projects_count, :rebounds_received_count, :shots_count, :teams_count, :can_upload_shot, :type, :pro, :buckets_url, :followers_url, :following_url, :likes_url, :shots_url, :teams_url, :created_at, :updated_at
    def self.find(user, options={})
      Underbelly::Search.new("/users/#{user}", options)
    end
    def self.muilt_find(user_names, options={})
      @users = user_names.strip.split(',').map do |user|
        find(user).user
      end
    end
    def initialize(values)
      values.each do |attribute_name, attribute_value|
        self.instance_variable_set("@#{attribute_name}", attribute_value)
      end    
    end

    
    def self.print_names_and_followers(user_names, options={})
      users = muilt_find(user_names, options)
      sorted_users = users.sort_by { |user| user.followers_count }.reverse
      mapped_user_and_followers = sorted_users.map do |user|
        "#{user.name} - #{user.followers_count}"
      end
      File.open("output.txt", "w+") do |f|
        mapped_user_and_followers.each { |element| f.puts(element) } 
      end
    end

  end
end