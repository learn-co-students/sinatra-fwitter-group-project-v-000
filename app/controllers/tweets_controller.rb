class TweetsController < ApplicationController

  get '/tweets/new' do #creates the create tweet page
    if logged_in?
    erb :'/tweets/create_tweet'
  end
  end

  post '/tweets' do  #post tweet
    @user = User.find_by( session[:user_id])
    @tweet = Tweet.create(content: params[:content], username: @user.username)
   redirect to "/tweets/#{@tweet.id}"
end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    erb :'/tweets/show'
  end

  get '/tweets' do
    if logged_in?
    @user = User.find_by(id: session[:user_id])
    erb:'/tweets/tweets'
  else
    redirect '/login'
    end
  end
end
