class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect to '/login'
    else
      @user = User.find(session[:user_id])
      erb :'/tweets/tweets'
    end
  end

  get '/tweets/new' do
    if logged_in? #doesn't load signup page if user is logged in
      erb :'tweets/create_tweet'
    else
      redirect to '/users/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      @tweet = Tweet.create(:content => params[:content], :user_id => session[:user_id])
      @tweet.save
      redirect to "/tweets"
    else
      flash[:message] = "You must enter tweet content"
      redirect to "/tweets/new"
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
  end

end
