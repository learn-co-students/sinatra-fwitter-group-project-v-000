class TweetsController < ApplicationController
  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.create(content: params[:content], user: current_user)
      redirect to '/tweets'
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

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

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user == current_user
      @tweet.delete
    end
    redirect to '/tweets'
  end
end
