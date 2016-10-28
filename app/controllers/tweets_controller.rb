class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'/tweets/tweets'
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
    if params[:content] == ""
      redirect "/tweets/new"
    else
      current_user.tweets.create(params)
      redirect "/tweets"
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

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect "/login"
    else
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == current_user.id 
        erb :'tweets/edit_tweet'      
      end
    end
  end

  patch '/tweets/:id' do
    if params[:content].empty?
      # binding.pry
      redirect "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end
  end

  post '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
      # binding.pry
      @tweet.destroy
      # @tweet = Tweet.find(params[:id])
      redirect '/tweets'
    end
  end

end