class TweetsController < ApplicationController

  # INDEX
  get '/tweets' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  # CREATE TWEET
  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect to '/tweets/new'
    else
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect to '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    end
  end


  # EDIT
  get '/tweets/:id/edit' do
    if !logged_in?
      redirect to '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id] #check the tweet's user id
         erb :'/tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content] == ""
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  # DELETE

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user == current_user
        @tweet.destroy
      end
      redirect to '/tweets'
    else
      redirect '/login'
    end
  end
end
