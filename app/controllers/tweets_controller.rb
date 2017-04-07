class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'

    else
      redirect "/login"

    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if params[:content] != ""
      @tweet = current_user.tweets.create(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = current_user.tweets.find_by(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
      if @tweet.user_id == current_user.id
        erb :'/tweets/edit_tweet'
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
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
