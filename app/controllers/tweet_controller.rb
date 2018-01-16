class TweetController < ApplicationController

  get '/tweets' do
    if session[:user_id].nil?
      redirect '/login'
    else
      @user = User.find(session[:user_id])
      @twitters = Tweet.all
      erb :'tweets/index_tweet'
    end

  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'tweets/index_tweet'
  end


  get '/tweets/new' do
    if session[:user_id].nil?
      redirect '/login'
    else
      erb :'tweets/create_tweet'
    end
  end

  post '/tweets' do
    @user = User.find(session[:user_id])
    @tweet = Tweet.new(content: params[:content], user_id: @user.id)
    if @tweet.save
      redirect "/tweets/#{tweet.id}"
    else
      flash[:message] = "Creation failure: please retry!"
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if session[:user_id].nil?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    end
  end

  get '/tweets/:id/edit' do
    if session[:user_id].nil?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      @user = User.find(session[:user_id])
      if @user.tweets.include?(@tweet)
        erb :'tweets/edit_tweet'
      end
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params[:content])
  end

  post '/tweets/:id/delete' do
    if session[:user_id].nil?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      @user = User.find(session[:user_id])
      if @user.tweets.include?(@tweet)
        @tweet.destroy
        redirect '/tweets'
      end
    end
  end

end
