class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do
    if logged_in? && params[:content] != ""
      @tweet = Tweet.create(:content => params[:content], :user_id => params[:user_id])
    else
      redirect to "/"
    end
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end

end
