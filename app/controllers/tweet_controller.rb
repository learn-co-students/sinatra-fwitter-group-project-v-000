class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end


  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in? && params[:content] != ""
      new_tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      current_user.tweets << new_tweet
      current_user.save
      redirect "/tweets/#{new_tweet.id}"
    elsif logged_in? && params[:content] == ""
      redirect '/tweets/new'
    else 
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slugs])
    erb :'tweets/user'
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && @tweet.user_id == session[:id]
      erb :'tweets/edit'
    elsif logged_in? && @tweet.user_id != session[:id]
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content] != ""
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else 
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && @tweet.user_id == session[:id]
      @tweet.delete
      redirect '/tweets'
    elsif logged_in? && @tweet.user_id != session[:id]
      redirect '/tweets'
    else
      redirect '/login'
    end

  end

end