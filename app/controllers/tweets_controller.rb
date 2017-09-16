class TweetsController < ApplicationController
  
  get '/tweets' do
    if User.is_logged_in?(session)
      erb :'/index'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if User.is_logged_in?(session)
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      @tweet = Tweet.create(params)
      @tweet.user_id = session[:id]
      @tweet.save
      erb :'/tweets/show_tweet'
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if User.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if User.is_logged_in?(session) && Tweet.find_by_id(params[:id]).user_id == session[:id]
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] != ""
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.update(content: params[:content])
      erb :'/tweets/show_tweet'
    else
      redirect to "/tweets/#{params[:id]}/edit"
    end
  end

  post '/tweets/:id/delete' do
    if User.is_logged_in?(session) && Tweet.find_by_id(params[:id]).user_id == session[:id]
      Tweet.delete(params[:id])
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

end