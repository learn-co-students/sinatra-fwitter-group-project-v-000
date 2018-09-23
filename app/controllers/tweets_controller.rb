class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    @user = User.find_by(params[:user_id])
    if logged_in?
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect :'/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect :'/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect :'/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
      redirect :"/tweets/#{@tweet.id}"
    else
      redirect :'/tweets/new'
    end
  end

  # patch '/tweets/:id' do
  #   @tweet = Tweet.find_by_id(params[:id])
  #   if params[:content].empty?
  #     redirect :"/tweets/#{params[:id]}/edit"
  #   else
  #     if @tweet && @tweet.user_id == current_user.id
  #       @tweet.update(content: params[:content])
  #       redirect "/tweets/#{@tweet.id}"
  #     else
  #       redirect "/tweets/#{@tweet.id}/edit"
  #     end
  #   end
  # end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if !params[:content].empty?
      @tweet.update(content: params[:content])
      redirect :"/tweets/#{@tweet.id}"
    else
      redirect :"/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in?
      if @tweet && @tweet.user == current_user
        @tweet.delete
      end
      redirect :'/tweets'
    else
      redirect :'/login'
    end
  end

  # delete '/tweets/:id/delete' do
  #   if logged_in?
  #     @tweet = Tweet.find_by(user_id: session[:user_id])
  #     @tweet.delete
  #     redirect :'/tweets'
  #   else
  #     redirect :'/login'
  #   end
  # end
end
