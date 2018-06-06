require 'pry'

class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      flash[:message] = "Please create an account"
      erb :'/users/new'
    else
      erb :'tweets/new'
    end
  end

  post '/tweets' do
    @user = User.find_by_id(session[:user_id])
    @tweet = Tweet.create(content: params[:content], user_id: @user.id, time: time.strftime("%Y-%m-%d %H:%M:%S"))
    # redirect to "/tweets/#{@tweet.id}"
    redirect to '/tweets'

  end

end