class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end


  get '/tweets/new' do
    if logged_in?
    erb :'/tweets/new'
    else
      redirect '/login'
    end
  end


  post '/tweets' do
    if !session[:user_id]
      redirect to '/'
    elsif !params[:content].empty?
      @user = User.find(session[:user_id])
      @tweet = Tweet.create(content: params[:content])
      @user.tweets << @tweet
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to 'tweets/new'
    end
  end



  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end


  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
      if logged_in? && @tweet.user_id == current_user.id
        erb :'/tweets/edit'
    else
      redirect '/login'
    end
  end


  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
      if !session[:user_id]
        redirect to '/'
      elsif session[:user_id] != @tweet.user.id
        redirect to '/tweets'
      elsif params[:content].empty?
        redirect to "/tweets/#{@tweet.id}/edit"
      else
        @tweet.update(content: params[:content])
        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
    end
  end


  delete '/tweets/:id' do
    if logged_in? && current_user
      @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user_id == current_user.id
      @tweet.delete
      redirect'/tweets'
    else
      redirect'/tweets'
    end
    else
      redirect '/login'
    end
  end
end
