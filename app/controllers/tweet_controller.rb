class TweetController < ApplicationController

  get '/tweets/new' do
    if !logged_in?
      redirect "/login"
    else
      erb :'tweets/create_tweet'
    end
  end

  post '/tweets' do
    if logged_in?
      if params[:content] != ""
      @tweet = current_user.tweets.create(content: params[:content])
        redirect '/tweets'
      else
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    if logged_in?
      @tweet= Tweet.all
      erb :'tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet= Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet= current_user.tweets.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      @tweet = current_user.tweets.find(params[:id])
      if params[:content] != ""
        @tweet.update(content: params[:content])
        redirect "/tweets/#{@tweet.id}"
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
    @tweet = Tweet.find(params[:id])
      if current_user.tweets.include?(@tweet)
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
