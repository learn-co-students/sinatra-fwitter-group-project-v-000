class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = User.find_by(session[:user_id])
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/create_tweet"
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.new(params)
      @tweet.user_id = current_user.id
      @tweet.save
      redirect "/tweets"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])

    if logged_in?
      erb :"/tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if !logged_in?
      redirect "/login"
    else
      if @tweet.user_id == current_user.id
        erb :"/tweets/edit_tweet"
      else
        redirect "/tweets"
      end
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])

    if params[:content].empty?
      redirect redirect "tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params[:content]
      @tweet.save
      redirect "tweets/#{@tweet.id}"
    end
  end


  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])

    if @tweet.user_id == current_user.id
      @tweet.delete
      redirect to '/tweets'
    else
      redirect "/tweets"
    end
  end
end
