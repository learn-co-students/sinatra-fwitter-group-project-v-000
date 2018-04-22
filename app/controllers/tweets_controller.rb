class TweetsController < ApplicationController

  get "/tweets" do
    if logged_in?
      @user =User.find_by(username: session[:username])
      erb :"/tweets/index"
    else
      redirect "/login"
    end
  end

  get '/tweets/:username' do
    if logged_in?
      # binding.pry
      @user = User.find_by(params[:user])
      erb :"/tweets/show"
    else
      redirect "/login"
    end
  end


end
