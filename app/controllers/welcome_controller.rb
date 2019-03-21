class WelcomeController < ApplicationController
  def index
  end

  def callback
    data = request.env['omniauth.auth']
    user = User.find_or_create_by(twitter_id: data.uid)
    user.raw = data.to_json
    user.save!
    cookies[:user_id] = user.id
    redirect_to :root
  end
end
