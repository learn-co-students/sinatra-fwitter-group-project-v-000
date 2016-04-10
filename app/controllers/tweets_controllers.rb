 class TweetsController < ApplicationController
 get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.create(content: params[:content], user: current_user)
      @user = current_user
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect "tweets/new"
      # erb :'/tweets/create_tweet', locals: {message: "You must include content."}
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.all.find_by_id(params[:id])
      if !@tweet.nil?
        erb :'tweets/show_tweet'
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && !@tweet.nil?
      erb :'tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if !params[:content].empty?
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user == current_user
      @tweet.delete
    end
    redirect to '/tweets'
  end
end