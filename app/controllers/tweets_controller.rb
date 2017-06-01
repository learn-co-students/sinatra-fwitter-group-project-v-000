class TweetsController < ApplicationController

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
      # current_user.id
    #  binding.pry
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user == current_user
        erb :'/tweets/edit'
      end
    else
    flash[:notice] = "You do not have permission to edit that tweet."
    redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      @user = @tweet.user
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params[:content])
    redirect "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id/delete' do
  if logged_in? && current_user.tweets.find_by(id: params[:id])
    @tweet = current_user.tweets.find_by(id: params[:id])
    if @tweet && @tweet.destroy
      @tweet.destroy
      redirect "/tweets"
    else
      redirect "/tweets/#{tweet.id}"
    end
  end
  end

  post '/tweets' do
    if logged_in?
      @tweet = Tweet.create(params)
      if @tweet.save
        @tweet = current_user.tweets.create(content: params[:content])
        flash[:notice] = "Successfully posted a new tweet."
        redirect '/tweets'
      else
        flash[:error] = @tweet.errors.full_messages
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

end
