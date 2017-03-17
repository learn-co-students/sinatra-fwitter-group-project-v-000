class TweetsController < ApplicationController

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/create' do
    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content])
      @tweet.user_id = current_user.id
      @tweet.user = current_user
      @tweet.save
      redirect "tweets/#{@tweet.id}/show"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets/:id/edit' do
    if logged_in? && params[:tweet] != ""
      @tweet = Tweet.find_by(id: params[:id])
      @tweet.content = params[:tweet]
      @tweet.save
      redirect "/tweets/#{@tweet.id}/show"
    elsif logged_in? && params[:tweet] == ""
      @tweet = Tweet.find_by(id: params[:id])
      redirect "/tweets/#{@tweet.id}/edit"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/show' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in? && current_user.id == User.find_by(username: params[:username]).id
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.delete
      redirect to '/tweets'
    else
      # @tweet = Tweet.find_by_id(params[:id])
      # @tweet.user_id = current_user.id
      # @tweet.user = current_user
      redirect '/tweets'
    end
  end


end
