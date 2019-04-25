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
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in? && params[:content] != ""
      @tweet = Tweet.create(content: params[:content])
      @tweet.user = User.find_by(params[:id])
      @tweet.save

      redirect "/tweets/#{@tweet.id}"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in? 
      @tweet = Tweet.find_by(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end  
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    @tweet.update(content: params[:content]) unless params[:content] = ""
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end
end
