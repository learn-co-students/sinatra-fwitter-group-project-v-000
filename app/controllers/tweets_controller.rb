class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user

      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'/tweets/create_tweet'
    else
      redirect "/users/login"
    end
  end

  post '/tweets/new' do
    @tweet = Tweet.new(content: params[:content])
    if !params[:content].empty?
      tweet = Tweet.create(content: params[:content])
      @user = current_user
      tweet.user_id = @user.id
      current_user.tweets << tweet
      current_user.save
      redirect '/tweets'
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

    get '/tweets/:id/edit' do
      if logged_in?
        @user = current_user
        @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/edit_tweet'
      else
        redirect '/login'
      end
    end

    patch '/tweets/:id' do
      @tweet = Tweet.find_by(content: params[:content])
      if !params[:content].empty?
        tweet = Tweet.update(content: params[:content])
        @user = current_user
        tweet.user_id = @user.id
        current_user.tweets << tweet
        current_user.save
        redirect '/tweets'
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
    end


  delete '/tweets/:id/delete' do #delete action
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.delete
  end

end
