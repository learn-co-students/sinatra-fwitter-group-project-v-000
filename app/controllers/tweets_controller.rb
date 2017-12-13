class TweetsController < ApplicationController

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get "/tweets" do
    if logged_in?
      erb :"tweets/tweets"
    else
      redirect :"/login"
    end
  end

end
