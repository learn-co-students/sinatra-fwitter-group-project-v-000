class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

   post '/tweets' do
    if params[:content] == ""
      redirect to "/tweets/new"
    else
      @tweet = Tweet.create(:content => params[:content])
      current_user.tweets << @tweet

      redirect to "/tweets/#{@tweet.id}"
    end
  end


   get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect "/login"
    end
  end

   get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in?
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content] != ""
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && @tweet.user_id == current_user.id
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/login'
    end
  end
end
