class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect to 'login'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'tweets/new'
    else
      redirect to 'login'
    end
  end

  post '/tweets/new' do
    if !params[:content].empty?
      user = Helpers.current_user(session)
      @tweet = Tweet.new(content: params[:content], user_id: user.id)
      @tweet.save
      redirect to "tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show'
    else
      redirect to 'login'
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/edit'
    else
      redirect to 'login'
    end
  end

  patch '/tweets/:id' do
    if !params[:content].empty? || Helpers.is_logged_in?(session)
      user = Helpers.current_user(session)
      @tweet = Tweet.find_by(id: params[:id])
      @tweet.update(content: params[:content])
      redirect to "tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    @user = Helpers.current_user(session)
    if Helpers.is_logged_in?(session) && @user == @tweet.user
      @tweet.delete
      redirect to "users/show"
    else
      redirect to 'login'
    end
  end
end
