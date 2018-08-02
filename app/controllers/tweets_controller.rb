class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/new' do
    #@tweet = current_user.tweets.build(content: params[:content])
    if params[:content].empty?
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      redirect "/tweets"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet
        erb :'tweets/show'
      else
        redirect "/tweets"
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet && @tweet.user == current_user
        erb :'tweets/edit'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.content = params[:content]
        @tweet.save

      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.content = params[:content]
        @tweet.delete

      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

end
