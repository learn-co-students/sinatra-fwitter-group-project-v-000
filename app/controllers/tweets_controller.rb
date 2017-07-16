class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      flash[:message] = "You must log in to access this page."
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      flash[:message] = "You must log in to access this page."
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      
      erb :'/tweets/show_tweet'
    else
      flash[:message] = "You must log in to access this page."
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      flash[:message] = "You left the content field blank. Please try again."
      redirect to '/tweets/new'
    else
      @tweet = current_user.tweets.create(:content => params[:content])
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id = current_user.id
        erb :'/tweets/edit_tweet'
      else
        flash[:message] = "You don't have permission to perform this action."
        redirect to '/tweets'
      end
    else
      flash[:message] = "You must log in to access this page."
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content] == ""
      flash[:message] = "You left the content field blank. Please try again."
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(:content => params[:content])
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        flash[:message] = "Tweet deleted."
        redirect '/tweets'
      else
        flash[:message] = "You don't have permission to perform this action."
        redirect '/tweets'
      end
    else
      flash[:message] = "You are currently not logged in."
      redirect '/login'
    end
  end

end