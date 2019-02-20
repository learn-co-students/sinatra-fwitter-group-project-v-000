class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :"/tweets/new"
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do

  end

  get '/tweets/:id/edit' do

  end

  patch '/tweets/:id' do

  end

  get '/tweets/:id/delete' do

  end


end
