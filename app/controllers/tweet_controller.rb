require 'pry'

class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/signup'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/edit'
  end

  post '/tweets' do
    if params[:content] == ""
      redirect to "/tweets/new"
    else
      @user = User.find_by_id(session[:user_id])
      @tweet = Tweet.create(content: params[:content], user_id: @user.id, time: Time.new.strftime("%Y-%m-%d %H:%M:%S"))

      redirect to '/tweets'
    end
  end

  patch '/tweets/:id' do
    if params[:content] == ""
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.update(content: params[:content], time: "Updated on #{Time.new.strftime("%Y-%m-%d %H:%M:%S")}")

      flash[:message] = "Tweet has been updated"
      erb :'tweets/show'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])

      if current_user == @tweet.user
        @tweet.destroy
      else
        redirect to '/tweets'
      end
    end

    redirect to '/login'
  end
end