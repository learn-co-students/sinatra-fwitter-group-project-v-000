class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :"/tweets/index"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/new"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/show"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if current_user == @tweet.user
        erb :"/tweets/edit"
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if current_user == @tweet.user
      if params[:content].empty?
        redirect "/tweets/#{@tweet.id}/edit"
      else
        @tweet.update(content: params[:content])
        @tweet.save
        redirect "/tweets"
      end
    else
      redirect "/tweets"
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect "/tweets/new"
    else
      tweet = current_user.tweets.create(content: params[:content])
      redirect "/tweets"
    end
  end

  delete '/tweets/:id/delete' do
    tweetid = params[:id]
    tweet = current_user.tweets.find_by(id: params[:id])
      if tweet && tweet.destroy
        redirect "/tweets"
      else
        redirect "/tweets/#{tweetid}"
      end
  end
end
