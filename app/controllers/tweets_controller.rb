class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      flash[:notice] = 'Please log in first to view tweets.'
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      # @user = current_user
      erb :'/tweets/create_tweet'
    else
      flash[:notice] = 'Please log in first to view tweets.'
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      flash[:notice] = 'Please log in first to view tweets.'
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        erb :'/tweets/edit_tweet'
      else
        flash[:notice] = 'You can only edit your own tweets.'
        redirect to "/tweets/#{params[:id]}"
      end
    else
      flash[:notice] = 'Please log in first to view tweets.'
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      #compare tweet.user_id to user.id
      tweet = current_user.tweets.find_by(id: params[:id])
      # tweet = Tweet.find_by_id(params[:id])
      if params.value?('')
        flash[:notice] = 'Cannot create empty tweet.'
        redirect to "/tweets/#{params[:id]}/edit"
      else
        tweet.update(content: params[:content])
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params.value?('')
      flash[:notice] = 'Cannot create empty tweet.'
      redirect to '/tweets/new'
    else
      user = User.find(session[:user_id])
      Tweet.create(user_id: user.id, content: params[:content])
      # @tweet.user_id = user.id #=> spec req user_id to be set before this line
      redirect to '/tweets'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      tweet = current_user.tweets.find_by(id: params[:id])
      if tweet
        tweet.delete
        redirect to '/tweets'
      else
        flash[:notice] = 'You can only delete your own tweets.'
        redirect to "/tweets/#{params[:id]}"
      end
    end
  end
end
