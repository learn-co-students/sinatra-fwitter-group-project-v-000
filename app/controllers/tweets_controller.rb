class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/index'
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
    tweet = Tweet.new(content: params[:content], user_id: session[:user_id])
    if tweet.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(params[:id])
    if logged_in? && @tweet.user_id == current_user.id
      erb :'/tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content].empty?
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by(params[:id])
      @tweet.update(content: params[:content])

      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweet/:id/delete' do
    if logged_in? && current_user
      @tweet = Tweet.find_by(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect '/tweets'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end
end
