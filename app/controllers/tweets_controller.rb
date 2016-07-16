class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  # lets user view new tweet form if logged in
  # lets user create a tweet if they are logged in
  # does not let user view new tweet form if not logged in
  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  # does not let a user tweet from another user
  # does not let a user create a blank tweet
  post '/tweets' do
    if params[:content].empty?
      redirect to "/tweets/new"
    else
      @user = current_user
      @tweet = Tweet.create(content:params[:content], user_id:@user.id)
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  # does not let a user view a tweet
  # displays a single tweet
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to "/login"
    end
  end

  # lets a user view tweet edit form if they are logged in
  # does not load let user view tweet edit form if not logged in
  # does not let a user edit a tweet they did not create
  # lets a user edit their own tweet if they are logged in
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == session[:user_id]
        erb :'tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to "/login"
    end
  end

  # does not let a user edit a text with blank content
  patch '/tweets/:id' do
    if !params[:content].empty?
      @tweet = Tweet.find(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{params[:id]}/edit"
    end
  end

  # lets a user delete their own tweet if they are logged in
  # does not let a user delete a tweet they did not create
  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == session[:user_id]
        @tweet.delete
        redirect to "/tweets"
      end
    else
      redirect to "/login"
    end
  end


end
