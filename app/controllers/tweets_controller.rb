require 'pry'
class TweetsController < ApplicationController

  get '/tweets' do
    #if logged_in?
      @user = User.find_by(session[:user_id])
      @tweets = Tweet.all
      if @user
        erb :'/tweets/show_tweet'
      else
        redirect '/login'
      end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in? && (params["content"] != "")
     @tweet = Tweet.create(content: params[:content], user: current_user)
   elsif @tweet
      erb :'/tweets/show_tweet'
    else
      redirect '/tweets/new'
    end
end

  get '/tweets/:id' do
    if logged_in?
    @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if session[:user_id] == @tweet.user_id
    @tweet.delete
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
    @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      if params[:content] == ""
      redirect "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.content = params[:content]
        @tweet.save
        redirect "/tweets/#{params[:id]}"
      end
    else
      redirect '/login'
    end
   end

end
