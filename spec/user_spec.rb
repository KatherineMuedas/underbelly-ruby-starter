require 'spec_helper'
describe Underbelly::User do
  it 'should find by team' do
    search = Underbelly::User.find("Facebook")
    expect(search) 
    expect(search.status).to eq(200)
    expect(search.user)
    expect(search.user).to be_a_kind_of(Underbelly::User)
    expect_attributes = %w(id name username html_url avatar_url bio location links buckets_count comments_received_count followers_count followings_count likes_count likes_received_count projects_count rebounds_received_count shots_count teams_count can_upload_shot type pro buckets_url followers_url following_url likes_url shots_url teams_url created_at updated_at)
    expect_attributes.each do |attribute|
      expect(search.user).to respond_to(attribute)
    end
  end

  
  it 'should search by multiple team names' do
    search = Underbelly::User.muilt_find("Facebook,Underbelly")
    expect(search) 
    expect(search).to be_a_kind_of(Array)
    expect(search.first).to be_a_kind_of(Underbelly::User)
    expect_attributes = %w(id name username html_url avatar_url bio location links buckets_count comments_received_count followers_count followings_count likes_count likes_received_count projects_count rebounds_received_count shots_count teams_count can_upload_shot type pro buckets_url followers_url following_url likes_url shots_url teams_url created_at updated_at)
    expect_attributes.each do |attribute|
      expect(search.first).to respond_to(attribute)
    end
  end

  it 'should print names of teams and followers' do
      Underbelly::User.print_names_and_followers("Facebook,Underbelly")
      expect(File).to exist("output.txt")
      expect_lines = ["Facebook - 11698\n", "Underbelly - 3652\n"]
      File.readlines("output.txt").each_with_index do |line, index|
        expect(line).to eql(expect_lines[index])
      end
  end
end
