class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all.reverse
      erb :'tweets/tweets'
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

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet
        erb :'tweets/show'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet && @tweet.user == current_user
        erb :'tweets/edit'
      else
        redirect "/tweets/#{@tweet.id}"
      end
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:username] != "" && params[:content] != ""
      Tweet.create(user_id: params[:user_id], content: params[:content])
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      tweet = Tweet.find_by(id: params[:id])
      if tweet && tweet.user == current_user && params[:tweet][:content] != ""
        tweet.update(content: params[:tweet][:content])
        redirect "/tweets/#{tweet.id}"
      else
        redirect "tweets/#{tweet.id}/edit"
      end
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      tweet = Tweet.find_by(id: params[:id])
      if tweet && tweet.user == current_user
        tweet.delete
      end
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

end
