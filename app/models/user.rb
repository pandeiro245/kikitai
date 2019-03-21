class User < ApplicationRecord
  # has_many :user_follows, class_name: "UserFollow", foreign_key: :user_id
  # has_many :follows, through: :user_follows
  # has_many :user_followers, class_name: "UserFollow", foreign_key: :follow_id
  # has_many :followers, through: :user_followers

  has_many :follow_followings, class_name: "Follow", foreign_key: :from_user_id
  has_many :followings, class_name: "User", through: :follow_followings
  has_many :follow_followers, class_name: "Follow", foreign_key: :to_user_id
  has_many :followers, class_name: "User", through: :follow_followers

  def api
    return @api if @api.present?
    @api = ::Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = twitter_token
      config.access_token_secret = twitter_secret
    end
  end

  def data
    @data || JSON.parse(raw)
  end

  def set_tokens
    data['credentials'].each do |key, val|
      send("twitter_#{key}=", val)
    end
    save!
  end

  def sync_followers
    sync('followers')
  end

  def sync_following
    sync('following')
  end

  def sync(key)
    begin
      api.send(key, 'pandeiro245').each_with_index do |twitter, i|
        sync_one(key, twitter, i)
        sleep 3
      end
    rescue=>e
      puts e.inspect
      if true
        sec = e.rate_limit.reset_in
        puts "sleep #{sec}seconds..."
        sleep sec
        sync(key)
      end
    end
  end

  def sync_one(key, twitter, i)
    begin
      twitter_id = twitter.to_hash[:id].to_s
      screen_name = twitter.to_hash[:screen_name]
      puts screen_name

      user = User.find_or_create_by(twitter_id: twitter_id)

      case key
      when 'followers'
        from_user_id = user.id
        to_user_id   = self.id
      when 'following'
        from_user_id = self.id
        to_user_id   = user.id
      end
      
      follow = Follow.find_or_create_by(from_user_id: from_user_id, to_user_id: to_user_id)
    rescue=>e
      puts e.inspect
      if true
        sec = e.rate_limit.reset_in
        puts "sleep #{sec}seconds..."
        sleep sec
        sync_one(key, twitter, i)
      end
    end
  end

end
