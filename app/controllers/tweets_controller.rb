class TweetsController < ApplicationController

  #### TWEETS INDEX ACTION ####

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      # binding.pry 
      @user = User.find(session[:user_id])
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  #### CREATE ACTIONS ####

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do 
    if params[:content] == ""
      redirect '/tweets/new'
    else
      user = current_user
      @tweet = Tweet.create(content: params[:content], user_id: user.id)
      # binding.pry
      redirect "/tweets/#{@tweet.id}"
    end
  end

  #### SHOW/READ ACTION ####

  get '/tweets/:id' do
    # binding.pry
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  #### EDIT ACTIONS ####

  get '/tweets/:id/edit' do
    @tweet = find_tweet(params)
    if logged_in? && @tweet.user_id == current_user.id
      erb :'/tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    # binding.pry
    if params[:content] == ""
      # binding.pry
      redirect "/tweets/#{params[:id]}/edit"
    else
      # binding.pry
      @tweet = find_tweet(params)
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end
  end

  #### DELETE ACTION ####

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == current_user.id
      @tweet.delete
      redirect '/tweets'
    else # if you ain't tweet it, you can't delete it!
      redirect '/login'
    end
  end

end