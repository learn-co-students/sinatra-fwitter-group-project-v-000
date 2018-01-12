class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @current_user = current_user
      erb :"tweets/index"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"tweets/new"
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.create(params)
      @tweet.user = User.find(session[:user_id])
      @tweet.save
      redirect "/tweets"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if current_user.tweets.include?(@tweet)
        erb :"/tweets/edit"
      else
        redirect "/tweets/#{params[:id]}"
      end
    else
      redirect "/login"
    end
  end

  post '/tweets/:id' do
    if !params[:content].empty?
      @tweet = Tweet.find(params[:id])
      @tweet.content = params[:content]
      @tweet.save
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  post '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if current_user.tweets.include?(@tweet)
        @tweet.delete
        redirect "/tweets"
      else
        redirect "/tweets/#{@tweet.id}"
      end
    else
      redirect "/login"
    end
  end

end
