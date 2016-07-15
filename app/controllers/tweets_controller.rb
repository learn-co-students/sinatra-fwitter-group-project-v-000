class TweetsController < ApplicationController

  get '/tweets' do
    @user = current_user
    redirect to('/login') unless is_logged_in?
    erb :'tweets/index'
  end

end
