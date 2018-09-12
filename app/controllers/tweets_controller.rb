class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = @user.tweets.order(created_at: :desc)
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      if params[:content] != ""
        @tweet = Tweet.new(content: params[:content])
        current_user.tweets << @tweet
        if @tweet.save
          redirect '/tweets'
        else
          redirect 'tweets/new'
        end
      else
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end

  get '/:username/:tweet_id' do
    if logged_in?
      @user = User.find_by(username: params[:username])
      @tweet = Tweet.find(params[:tweet_id])
      erb :'/tweets/view'
    else
      redirect '/login'
    end
  end

  get '/:username/:tweet_id/edit' do
    if logged_in?
      if current_user.username == params[:username]
        @user = User.find_by(username: params[:username])
        @tweet = Tweet.find(params[:tweet_id])
        erb :'/tweets/edit'
      else
        redirect "/#{params[:username]}/#{params[:tweet_id]}"
      end
    else
      redirect '/login'
    end
  end

  patch '/:username/:tweet_id' do
    if logged_in? && current_user.username == params[:username] && params[:content] != ""
      @tweet = Tweet.find(params[:tweet_id])
      @tweet.update(content: params[:content])
      if @tweet.save
        redirect "/#{params[:username]}/#{params[:tweet_id]}"
      else
        redirect "/#{params[:username]}/#{params[:tweet_id]}/edit"
      end
    else
      redirect "/#{params[:username]}/#{params[:tweet_id]}/edit"
    end
  end

  get '/:username/:tweet_id/delete' do
    if logged_in? && current_user.username == params[:username]
      @tweet = Tweet.find(params[:tweet_id])
      @tweet.delete
      redirect "/#{params[:username]}"
    else
      redirect "/#{params[:username]}/#{params[:tweet_id]}"
    end
  end

  get '/:username' do
    if logged_in?
      if params[:username] == current_user.username
        redirect '/tweets'
      else
        @user = User.find_by(username: params[:username])
        @tweets = @user.tweets.order(created_at: :desc)
        erb :'/tweets/index'
      end
    else
      redirect '/login'
    end
  end

end
