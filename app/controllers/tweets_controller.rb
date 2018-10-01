class TweetsController < ApplicationController

  get '/tweets' do
    @tweet = Tweet.all
    if logged_in?
      erb :'/tweets/tweets'
    else
      redirect '/users/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect 'users/login'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
    end
    redirect '/tweets'
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in?
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
       @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect '/users/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content] == ""
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user == current_user
        @tweet.delete
      end
    end

  end
end
