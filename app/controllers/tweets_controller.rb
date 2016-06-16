class TweetsController < ApplicationController

  get '/tweets' do
    if session[:user_id]
      @tweets = Tweet.all
      @user = User.find(session[:user_id])
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if session[:user_id]
      erb :'/tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if session[:user_id]
      if params[:content].empty?
        redirect "/tweets/new"
      else
        @tweet = Tweet.new(content: params[:content], user_id: session[:user_id])
        @tweet.save
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      if session[:user_id] == @tweet.user_id
        erb :'/tweets/edit_tweet'
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    if params[:content].empty?
      redirect "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = (params[:content])
      @tweet.save
      redirect "/tweets" 
    end
  end

  delete '/tweets/:id/delete' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      if session[:user_id] == @tweet.user_id 
        @tweet.delete
        redirect "/tweets"
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

end