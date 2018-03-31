class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :"/tweets/tweets"
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    @tweet = Tweet.create(content: params["content"], user_id: current_user.id)
    redirect to '/tweets'
  end

  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/create_tweet"
    else
      redirect to '/'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    erb :"/tweets/show_tweet"
  end
end
