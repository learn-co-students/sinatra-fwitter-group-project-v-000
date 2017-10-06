class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect to "/login"
    end
  end

  post '/tweets' do
    # @user = User.find_by(:username => params[:username])
    if params[:content] != "" #if tweet is not blank
      @tweet = current_user.tweets.create(:content => params[:content])
      redirect to "/tweets"
    else
      redirect to "/tweets/new"
    end

  end

  get '/tweets/:id' do
    # @user = User.find_by(:username => params[:username])
    if logged_in?
      # binding.pry
      @tweet = Tweet.find_by_id(params[:id]) #not found by content, but specifically by id
      erb :"/tweets/show_tweet"
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/edit_tweet"
    else
      redirect to "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])

    if logged_in? && params[:content] != ""
      @tweet.update(:content => params[:content])
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  post '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      # binding.pry
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect to "/tweets"
      else
        redirect to "/tweets"
      end
    else
      redirect to "/login"
    end
    # @tweet = Tweet.find_by_id(params[:id])
    # if logged_in? && @tweet.user_id == session[:user_id]
    #   @tweet.destroy
    #   redirect to "/tweets"
    # else
    #   redirect to "/login"
    # end
  end

end
