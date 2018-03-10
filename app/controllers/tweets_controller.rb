class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'tweets/index'
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if logged_in? then erb :'tweets/new' else redirect "/login" end
  end

  post '/tweets/show' do
    if logged_in? && !params["content"].empty?
      current_user.tweets.create(params)
    else
      redirect "/tweets/new"
    end
    current_user.save
    redirect to "/tweets"
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit'
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    if !logged_in?
      redirect to "/login"
    elsif logged_in? && !params["content"].empty?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.update(content: params["content"])
    else
      redirect to "/tweets/#{params[:id]}/edit"
    end

    redirect to "/tweets"
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])

    if @tweet.user == current_user then @tweet.delete else redirect "/login" end
      
    redirect "/tweets"
  end

end
