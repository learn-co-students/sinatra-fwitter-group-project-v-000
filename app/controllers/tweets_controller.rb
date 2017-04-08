class TweetsController < ApplicationController
  get '/tweets' do
    if !logged_in?
      redirect "/login"
    else
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect "/login"
    else
      erb :'/tweets/create_tweet'
    end
  end

  post '/tweets' do
    if params[:content].strip != ""
      @tweet = current_user.tweets.create(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect "/login"
    else
      @tweet = Tweet.find_by(params[:id])
      erb :'/tweets/show_tweet'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect "/login"
    else
      @tweet = Tweet.find_by(params[:id])
      if @tweet.user_id == current_user.id
        erb :'/tweets/edit_tweet'
      else
        redirect "/tweets"
      end
    end
  end

  patch '/tweets/:id' do
    if params[:content] != ""
      @tweet = Tweet.find_by(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by(params[:id])
    if @tweet.user_id == current_user.id
      @tweet.delete
      redirect "/tweets"
    else
      redirect "/tweets"
    end
  end
end
