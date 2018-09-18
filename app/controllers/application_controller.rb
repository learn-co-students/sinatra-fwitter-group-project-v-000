require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "auth_demo_lv"
  end

  get '/' do
    erb :"index"
  end


  # delete '/tweets/:id/delete' do
  #   @tweets = Tweet.find(params[:id])
  #   @tweets.delete
  #   erb :"/delete"
  # end

  helpers do

    def current_user

    end

    def logged_in?
      !!session[:email]
    end

    def login(email)
      if user = User.find_by(email: "email")
        session[:email] = user.email
      else
        redirect '/login'
      end
      session[:email] = email
    end

    def logout!
      session.clear
    end
end
end
