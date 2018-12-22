class TweetsController < ApplicationController


  get '/tweets' do
    if User.find_by_id(session[:user_id]) == nil
      redirect '/login'
    else
      @user = User.find_by_id(session[:user_id])
      erb :'/tweets/index'
    end
  end

  get '/tweets/new' do
    if User.find_by_id(session[:user_id]) == nil
      redirect '/login'
    end
    erb :'/tweets/new'
  end

  post '/tweets' do

    if params[:new_tweet].empty?
      redirect :'/tweets/new'
    end

    user = User.find_by_id(session[:user_id])
    @tweet = Tweet.new(content: params[:new_tweet])
    @tweet.user_id = session[:user_id]
    @tweet.save
    erb '/tweets/show'
  end

  get '/tweets/:id' do
    if User.find_by_id(session[:user_id]) == nil
      redirect '/login'
    end
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/show'
  end

  delete '/tweets/:id/delete' do

    if User.find_by_id(session[:user_id]) == nil
      redirect '/login'
    end

    @user = User.find_by_id(session[:user_id])


    if @user.tweets.include?(Tweet.find_by_id(params[:id]))

      Tweet.find_by_id(params[:id]).delete
      redirect '/tweets'
    end
    redirect '/tweets'
  end


end
