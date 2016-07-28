class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
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
    if params[:content].strip.empty?
      redirect '/tweets/new'
    else
      user = current_user
      tweet = Tweet.create(content: params[:content], user_id: user.id)
      redirect "/tweets/#{tweet.id}"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @username = current_user.username
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:id])
      if logged_in? && @tweet.user_id == @user.id
        erb :'/tweets/edit_tweet'
      else
        redirect 'tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if params[:content].strip.empty?
      redirect "/tweets/#{tweet.id}/edit"
    else
      tweet.content = params[:content]
      tweet.save
      redirect "/tweets/#{tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    if tweet.user == current_user
      tweet.destroy
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

end
