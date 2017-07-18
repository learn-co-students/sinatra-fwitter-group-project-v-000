class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @user = User.find_by_id(session[:id])
      @tweets = Tweet.all
      erb :'tweets/tweets_index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      @user = User.find_by_id(session[:id])
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @user = User.find_by_id(session[:id])
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
      @user = User.find_by_id(session[:id])
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content].size > 0
      @user = User.find_by_id(session[:id])
      @tweet = Tweet.create(content: params[:content])
      @user.tweets << @tweet
      erb :'tweets/show_tweet'
    else
      redirect '/tweets/new'
    end
  end

  post '/tweets/:id' do
    if params[:content].size > 0
      @user = User.find_by_id(session[:id])
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      erb :'tweets/show_tweet'
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    if Helpers.is_logged_in?(session)
       @tweet = Tweet.find_by_id(params[:id])
       if @tweet.user_id == Helpers.current_user(session).id
        @tweet.delete
        @user = User.find_by_id(session[:id])
        erb :'tweets/delete_tweet'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

end
