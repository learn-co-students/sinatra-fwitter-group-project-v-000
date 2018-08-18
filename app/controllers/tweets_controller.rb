class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect to '/login'
    else
      @user = User.find(session[:user_id])
      erb :'/tweets/tweets'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      @tweet = Tweet.create(:content => params[:content], :user_id => session[:user_id])
      @tweet.save
      redirect to "/tweets"
    else
      redirect to "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/edit_tweet"
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content] != ""
      @tweet.update(:content => params[:content])
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == session[:user_id]
      @tweet = Tweet.delete(params[:id])
      redirect to '/tweets'
    else
      redirect to '/tweets'
    end
  end

end
