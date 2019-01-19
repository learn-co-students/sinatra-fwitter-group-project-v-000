class TweetsController < ApplicationController
  #
  get '/tweets' do
    # Is there a way to use helper methods?
    if !!session[:user_id]
      @user = User.find(session[:user_id])
      erb :'/tweets/index'
    else
      redirect "/login"
    end
  end


  get '/tweets/new' do
    # Is there a way to use helper methods?
    if !!session[:user_id]
      @user = User.find(session[:user_id])
      erb :'/tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    # Is there a way to use helper methods?
    if !!session[:user_id]
      @tweet = Tweet.create(params[:tweet])
      # Need to assign user_id to tweet
      @tweet.user = User.find(session[:user_id])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    # binding.pry
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/show'
  end
  # get '/tweets/new' do
  #   erb :'/tweets/new'
  # end
  #
  # post '/tweets' do
  #   @tweet = Tweet.create(params[:tweet])
  #   # Need to assign user_id to tweet
  #   redirect "/tweets/#{@tweet.id}"
  # end
  #
  # get '/tweets/:id' do
  #   @tweet = Tweet.find_by_id(params[:id])
  #   erb :'/tweets/show'
  # end

end
