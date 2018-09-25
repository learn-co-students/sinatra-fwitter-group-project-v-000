require 'pry'
class TweetsController < ApplicationController

  get '/tweets' do  # tweet / GET request / read action
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do    #CREATE action - GET request
    if logged_in?
      @user = current_user
      erb :'/tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweet' do     #CREAT action - POST request
    if !params[:content].empty?
      tweet = Tweet.create(:content => params[:content])
      @user = current_user
      @user.tweets << tweet
      @user.save
      redirect "/tweets"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do   # Get action / Update request
    if logged_in?
      @user = current_user
      @tweet = Tweet.find_by(params[:content], params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do   # Get action / edit request
    @tweet = Tweet.find_by(params[:id])
    if logged_in? && @tweet.user == current_user
      erb :"/tweets/edit_tweet"
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do    # Patch action /edit request
    @tweet = Tweet.find_by(params[:id])
    if !params[:content].empty?
      @tweet.update(:content => params[:content])
      @tweet.save
      redirect "tweets/#{params[:id]}"
    else
      redirect "tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id/delete' do   # Delete action / Delete request
    if logged_in?
  @tweet = Tweet.find_by_id(params[:id])
  if @tweet && @tweet.user == current_user

         @tweet.destroy
      redirect "/tweets"
    else
      redirect "/login"
    end
  end
end


  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
