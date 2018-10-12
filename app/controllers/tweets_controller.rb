class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.logged_in?(session)
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if Helpers.logged_in?(session)
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params["tweet"]["content"].empty?
      @tweet = Tweet.create
      @tweet.content = params["tweet"]["content"]
      @tweet.save
      @user = Helpers.current_user(session)
      @user.tweets << @tweet
      @user.save
      @tweets = @user.tweets
      erb :'tweets/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if Helpers.logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      @user = User.find_by_id(@tweet.user_id)
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if !Helpers.logged_in?(session)
      redirect '/login'
    elsif Helpers.current_user(session).tweets.include?(@tweet)
        erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id]) #needs to be outside if statement for redirect to work
    if !params["tweet"]["content"].empty?
      @tweet.content = params["tweet"]["content"]
      @tweet.save
      @user = User.find_by_id(@tweet.user_id)
      erb :'tweets/show_tweet'
    else
      redirect redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  get '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if !Helpers.logged_in?(session)
      redirect '/login'
    elsif Helpers.current_user(session).tweets.include?(@tweet)
      erb :'tweets/delete'
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if !Helpers.logged_in?(session)
      redirect '/login'
    elsif Helpers.current_user(session).tweets.include?(@tweet)
      @tweet.destroy
      redirect '/tweets'
    else
      redirect '/login'
    end
  end


end
