class TweetsController < ApplicationController

  get '/tweets' do
    if is_logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if is_logged_in?
      if params[:content] != ""
        @tweet = Tweet.create(params)
        @tweet.user_id = current_user.id
        @tweet.save
        redirect "/tweets/#{@tweet.id}"
      else
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if is_logged_in?
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in?
      @tweet = Tweet.find(params[:id])
      if session[:user_id] == @tweet.user_id
        erb :'/tweets/edit_tweet'
      else
        redirect "/tweets"
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] != ""
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if session[:user_id] == @tweet.user_id
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/tweets'
    end
  end


end
