class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :tweets
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :new
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :show
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :edit
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    tweet = Tweet.find(params[:id])

    if tweet.user == current_user
      if !params[:content].empty?
        tweet.update(content: params[:content])
        tweet.save
        redirect "/tweets/#{tweet.id}"
      else
        redirect "/tweets/#{tweet.id}/edit"
      end
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    tweet.delete if tweet.user == current_user
    redirect '/tweets'
  end

end
