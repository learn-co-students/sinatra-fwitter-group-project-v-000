class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :"tweets/tweets"
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"tweets/create_tweet"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if logged_in?
      erb :"tweets/show_tweet"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if session[:user_id] == @tweet.user_id
        erb :"tweets/edit_tweet"
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:tweet][:content].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(params[:tweet])
    end
  end

  post '/tweets' do
    @user = current_user
    if params[:content].empty?
      redirect '/tweets/new'
    else
      @tweet = @user.tweets.build(params)
      @user.save
      redirect "tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if session[:user_id] == @tweet.user_id
      @tweet.delete
      redirect '/tweets'
    else
      redirect "/tweets"
    end
  end

end
