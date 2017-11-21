class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      current_user.tweets.create(content: params[:content])
      redirect '/users/#(current_user.slug)'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    if params[:content] != ""
      @tweet.update(params[:content])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

end
