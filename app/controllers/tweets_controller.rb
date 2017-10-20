class TweetsController < ApplicationController

  get '/tweets/new' do
    login_check
    erb :'tweets/new'
  end

  post '/tweets' do
    if params[:content].empty?
      flash[:message] = "Oops! Your tweet is blank!"
      redirect '/tweets/new'
    end
    @user = User.find(session[:user_id])
    @tweet = @user.tweets.create(content: params[:content])

    redirect "/tweets/#{@tweet.id}"
  end

  get '/tweets' do
    login_check
    @user = User.find(session[:user_id])
    erb :'tweets/index'
  end

  get '/tweets/:id' do
    login_check
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show'
  end

  get '/tweets/:id/edit' do
    login_check
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit'
  end

  patch '/tweets/:id' do
    if !params[:content].empty?
      @tweet = Tweet.find(params[:id])
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      flash[:message] = "Oops! Your tweet was blank!"
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    login_check
      @tweet = Tweet.find(params[:id])
      if session[:user_id] == @tweet.user_id
        @tweet.destroy
        erb :'tweets/delete'
      else
        flash[:message] = "You may not delete a tweet you did not create."
        redirect '/login'
      end
  end

end
