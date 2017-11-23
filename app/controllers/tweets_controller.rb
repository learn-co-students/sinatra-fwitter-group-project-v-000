class TweetsController < ApplicationController

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      flash[:message] = "Please Login to create a new tweet"
      redirect to '/login'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] == "" || params[:content] == " " || params[:content] == "  "
      flash[:message] = "Your tweet cannot be empty"
      redirect to '/tweets/new'
    else
      @user = User.find_by(id: session[:user_id])
      @tweet = Tweet.create(content: params[:content], user_id: @user.id)
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      flash[:message] = "Please login to access this page"
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] == "" || params[:content] == " " || params[:content].length < 2
      flash[:message] = "Tweet cannot be empty"
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == session[:user_id]
      @tweet.destroy
    else
      flash[:message] = "You cannot delete some elses tweet"
      redirect '/login'
    end
  end

end
