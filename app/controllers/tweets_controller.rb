class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
   if logged_in?
      @user = current_user
      erb :"/tweets/create_tweet"
    else
      redirect to '/users/login'
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect to '/tweets/new'
    else
      @tweet = Tweet.new(content: params[:content])
      @tweet.user_id = current_user.id
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end
  end


  get '/tweets/:id' do 
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else 
      redirect to '/users/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do 
     @tweet = Tweet.find(params[:id])
    if !params[:content].empty?
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

end