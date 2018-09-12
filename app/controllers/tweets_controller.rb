class TweetsController < ApplicationController

  get '/tweets/new' do
    if !logged_in?
      redirect to '/login'
    end
    erb :'tweets/new'
  end

  post '/tweets' do
    if params[:content] == ""
      redirect to '/tweets/new'
    end
    @tweet = Tweet.new(content: params[:content])
    @tweet.user_id = current_user.id
    @tweet.save
    redirect to "/tweets"
  end

  get '/tweets' do
    if !logged_in?
      redirect to '/login'
    end
    erb :'/tweets/index'
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect to '/login'
    end
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/show'
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect to '/login'
    end
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/edit'
  end

  patch '/tweets/:id' do
    if params[:content] == ""
      redirect to "/tweets/#{params[:id]}/edit"
    end
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.update(content: params[:content])
    redirect to "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id' do
    if !logged_in?
      redirect to '/login'
    end
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet && @tweet.user_id == session[:user_id]
      @tweet.destroy
    end
    redirect to '/tweets'
  end
end
