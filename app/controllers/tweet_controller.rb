class TweetController < ApplicationController

  get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    else
      @user = current_user
      erb :"/tweets/new"
    end
  end

  post '/tweets' do
    @tweet = Tweet.new(content: params[:tweet][:content])
    @tweet.user = current_user
    if @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets' do
    if !logged_in?
      redirect "/login"
    else
      @user = current_user
      @tweets = Tweet.all
      erb :"/tweets/index"
    end
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect "/login"
    else
      @tweet = Tweet.find(params[:id])
      @user = @tweet.user
      erb :"/tweets/show"
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect "/login"
    else
      @tweet = Tweet.find(params[:id])
      if @tweet.user = current_user
        @user = current_user
        erb :"/tweets/edit"
      else
        redirect "/tweets"
      end
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params[:tweet][:content])
    if @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    if !logged_in?
      redirect "/login"
    else
      @tweet = Tweet.find(params[:id])
      if @tweet.user != current_user
        flash[:message] = "Users can only delete their own tweets."
        redirect "/tweets"
      else
        @tweet.delete
        flash[:message] = "Successfully deleted tweet."
        redirect "/tweets"
      end
    end
  end

end
