class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      erb :"/tweets/index"
    else redirect to :"/login"
    end
  end
  
  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/new"
    else redirect to :"/login"
    end
  end
  
  post '/tweets' do
    if params[:content].present?
      @user = current_user
      @tweet = Tweet.create(:content => params[:content], :user_id => params[:user_id])
      @tweet.user_id = @user.id
      @tweet.save
      erb :"/tweets/index"
    else redirect to :"/tweets/new"
    end
  end
  
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/show"
    else redirect to :"/login"
    end
  end
  
  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by(params[:content])
      @tweet.delete
      erb :"/tweets/index"
    else redirect to :"/login"
    end
  end
  
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/edit"
    else redirect to :"/login"
    end
  end
  
  patch '/tweets/:id/edit' do
    if params[:content].present?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      erb :"/tweets/index"
    else erb :"/tweets/edit"
    end
  end

end
