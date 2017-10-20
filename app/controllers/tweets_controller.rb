require 'pry'
class TweetsController < ApplicationController

  get '/tweets' do # all tweets page, only allowed if logged in
    if logged_in?
      @user = User.find(session[:user_id])
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/create_tweet"
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if params.has_value?("")
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        erb :"/tweets/edit_tweet"
      else
        redirect '/tweets'
      end
    else
      redirect "/login"
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect '/login'
    end
  end

  patch "/tweets/:id" do
    @tweet = Tweet.find_by_id(params[:id])
    if params.has_value?("")
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do #delete action
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect to "/users/#{@tweet.user.slug}"
      else
        redirect '/tweets'
      end
    else
      redirect to '/login'
    end
  end


end
