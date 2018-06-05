class TweetController < ApplicationController


  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/create_tweet"
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      if params[:content] != ""
        tweet = Tweet.new(content: params[:content])
        tweet.user = current_user
        tweet.save
      else
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/edit_tweet"
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if params[:content] == ""
        redirect "/tweets/#{@tweet.id}/edit"
      else

        @tweet.update(content: params[:content])
        redirect "/tweets/#{@tweet.id}/edit"
      end
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/delete' do
    if logged_in?
      tweet = Tweet.find(params[:id])
      if tweet.user == current_user
        tweet.delete
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

end
