class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?
      # binding.pry
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets/new' do
    if logged_in? && !params["content"].empty?
      @user = current_user

      @tweet = Tweet.new(content: params["content"])
      @tweet.user = @user
      @tweet.save
    end
    redirect to '/tweets/new'
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      @user = @tweet.user
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    # binding.pry
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user == current_user
        erb :'/tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && !params["content"].empty?
      @tweet.update(content: params["content"])
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end


  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user == current_user
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end
end
