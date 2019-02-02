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
      @user = current_user
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
      @user = current_user
      @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
      @user.tweets << @tweet
      redirect '/tweets'
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

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id/edit' do
    if params[:content] == ""
      redirect "/tweets/#{params[:id]}/edit"
    else
      if Tweet.find(params[:id]).user_id == session[:user_id]
        @user = current_user
        @tweet = @user.tweets.find(params[:id])
        @tweet.content = params[:content]
        @tweet.save
        redirect "/tweets/#{params[:id]}"
      else
        redirect '/tweets'
      end
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @tweet.delete if @tweet.user == current_user
    redirect to '/tweets'
  end
end
