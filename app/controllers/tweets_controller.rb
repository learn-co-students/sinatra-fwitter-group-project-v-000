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

  post '/tweets/new' do
    tweet = Tweet.new(params[:tweet])
    if tweet.valid? && tweet.content != ""
      tweet.save
      current_user.tweets << tweet
      redirect to("/tweets/#{tweet.id}")
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    @tweet =  Tweet.find_by_id(params[:id])
    if logged_in? && @tweet.user == current_user
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if !@tweet.nil? && logged_in?
      if @tweet.user == current_user
        erb :'/tweets/edit'
      else
        redirect '/login'
      end
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/edit' do
    tweet = Tweet.find_by_id(params[:id])
    if tweet.user == current_user
      if !params[:tweet][:content] == "" || !params[:tweet][:content].nil?
        tweet.content = params[:tweet][:content]
        tweet.save
        redirect to("/tweets/#{tweet.id}/edit")
      else
        redirect to("/tweets/#{params[:id]}/edit")
      end
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    if logged_in? && params["Delete Tweet"]
      tweet = Tweet.find_by_id(params[:id])
    end
    if current_user == tweet.user
      tweet.destroy
      redirect '/tweets'
    else
      redirect to("/tweets/#{params[:id]/edit}")
    end
  end

end
