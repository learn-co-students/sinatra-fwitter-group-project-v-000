class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @all_tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.all.find {|tweet| tweet.id == params[:id].to_i}
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find_by_id(params[:id])
      if @user.id == @tweet.user_id
        erb :'tweets/edit'
      end
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      @user = current_user
      if !params[:content].empty?
        @user.tweets.create(params)
        redirect '/tweets'
      else
        redirect '/tweets/new'
      end
    else
      redirect '/'
    end
  end

    patch '/tweets/:id/edit' do
      @tweet = Tweet.find_by_id(params[:id])
      if !params[:content].empty?
        @tweet.update(content: params[:content])
        @tweet.save
        redirect "/tweets/#{@tweet.id}"
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
    end

    delete '/tweets/:id/delete' do
      if logged_in?
        @user = current_user
        @tweet = Tweet.find_by_id(params[:id])
        if @user.id == @tweet.user_id
          @tweet.destroy
        end
      else
        redirect '/login'
      end
    end

end
