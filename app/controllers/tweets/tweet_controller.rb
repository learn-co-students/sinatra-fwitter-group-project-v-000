class TweetController < ApplicationController

  get '/tweets' do
    if Helpers.current_user(session)
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    if Helpers.current_user(session)
      @tweet = Tweet.new(content: params[:content])
      if @tweet.content == ""
        redirect '/tweets/new'
      else
        @tweet.user_id = session[:user_id]
        @tweet.save
        erb :'tweets/show_tweet'
      end
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      if session[:user_id] == @tweet.user_id
        erb :'tweets/edit_tweet'
      else
        redirect '/login'
      end
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      if params[:content] == ""
        redirect "/tweets/#{@tweet.id}/edit"
      else
        @tweet.update(content: params[:content])
        @tweet.save
        redirect "/tweets/#{@tweet.id}"
      end
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
        @tweet.destroy
        redirect "/tweets"
      end
    else
      redirect '/login'
    end
  end
end
