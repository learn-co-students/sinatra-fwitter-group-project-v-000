class TweetsController < ApplicationController

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    tweet = Tweet.new(content: params[:content], user: current_user)
    if tweet.save
      redirect to '/tweets'
    else
      flash[:tweet_errors] = tweet.errors.full_messages.join(", ")
      redirect to '/tweets/new'
    end
  end

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect to '/login'
    end
  end

#was /tweets
  get '/users/:slug' do
    #if logged_in?
      @user = User.all.find { |user| user.slug == params[:slug]}
      if @user
        @tweets = @user.tweets
        erb :'tweets/user_tweets'
      else
        erb :'tweets/failure'
      end
    #else
      #redirect to '/login'
    #end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet
        #if @tweet.user_id == current_user.id
        erb :'tweets/show'
        #else
          #erb :'tweets/permission_denied'
        #end
      else
        erb :'tweets/failure'
      end
    else
      redirect to '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      tweet = current_user.tweets.find_by(id: params[:id])
      if tweet
        tweet.delete
        redirect to "/users/#{current_user.slug}"
      else
        erb :'tweets/failure'
      end
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = current_user.tweets.find_by(id: params[:id])
      if @tweet
        erb :'/tweets/edit'
      else
        erb :'tweets/failure'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      tweet = current_user.tweets.find_by(id: params[:id])
      if tweet.update(params[:tweet])
        redirect to "/users/#{current_user.slug}"
      else
        flash[:tweet_errors] = tweet.errors.full_messages.join(", ")
        redirect to "tweets/#{params[:id]}/edit"
      end
    else
      redirect to '/login'
    end
  end

end
