class TweetsController < ApplicationController

# Show tweets index
  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweet' do
    if !params[:content].empty?
      tweet = Tweet.create(content: params[:content])
      tweet.user_id = current_user.id
      tweet.save
      redirect "/tweets/#{tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
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
    if logged_in? && !params[:content].empty?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{params[:id]}/edit" #note that we use params[:id] because @tweet doesn't exist if the first condition is false.
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in? && current_user.id == session[:user_id]
      @tweet = Tweet.find_by(params[:content])
      @tweet.destroy
    else
      redirect '/login'
    end
  end





end
