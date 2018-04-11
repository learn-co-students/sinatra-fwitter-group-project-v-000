class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
        @tweets = Tweet.all
        erb :'/tweets/tweets'
    else
        redirect '/login'
    end
  end

  get '/tweets/new' do
    #load create tweet form
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    #individual show tweet page
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    #load form to edit tweet
    #find specific tweet from params[:id] to preload form
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    #submit and catch the data and create new tweet object
    #redirect to individual tweet page
    if params[:content] == ""
      redirect to "/tweets/new"
    else
    @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    #delete tweet by :id
    @tweet = Tweet.find_by_id(params[:id])
    binding.pry
    if logged_in? && @tweet.user_id == current_user
      @tweet.delete

      erb :'/index'
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content] == ""
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.update(content: params[:content])
      @tweet.save
      #binding.pry
      redirect "/tweets/#{@tweet.id}"
    end
  end





end
