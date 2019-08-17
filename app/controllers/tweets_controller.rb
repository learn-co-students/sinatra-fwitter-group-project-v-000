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
      if params[:content] == ""
       redirect "/tweets/new"
     else
      @tweet = Tweet.create(content: params[:content])
      @current_user = User.find_by_id(session[:user_id])
      @tweet.user_id = @current_user.id
      @tweet.save
      end
      redirect to "/tweets/#{@tweet.id}"
    end

    get '/tweets/:id' do
      if !logged_in?
        redirect to '/login'
      else
        @tweet = Tweet.find_by_id(params[:id])

        erb :'/tweets/show_tweet'
      end
    end

end
