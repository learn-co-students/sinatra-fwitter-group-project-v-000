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
      erb :'/tweets/new_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if !params[:tweet][:content].empty?
      @tweet = Tweet.create(params[:tweet])
      @tweet.user_id = session[:user_id]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])

    if !params[:tweet][:content].empty?
      @tweet.update(params[:tweet])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete "/tweets/:id" do
    @tweet = Tweet.find_by_id(params[:id])
    Tweet.destroy(params[:id]) if session[:user_id] == @tweet.user_id
    redirect '/tweets'
  end
end
