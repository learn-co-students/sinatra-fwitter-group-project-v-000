class TweetsController < ApplicationController

  configure do
    enable :sessions unless test?
    set :session_secret, "password_security"
  end

    get '/tweets/new' do
      if !logged_in?
        redirect to '/login'
      else
        @current_user = User.find_by_id(session[:user_id])
        erb :'/tweets/new'
      end
    end

    post '/tweets' do
      # binding.pry

    end

end
