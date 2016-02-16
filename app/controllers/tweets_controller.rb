class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      @user = current_user
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

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id].to_i)
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @tweet = Tweet.new(content: params[:content], user_id: current_user.id)
    if @tweet.save
      redirect '/tweets'
    else
      redirect 'tweets/new'
    end
  end

  delete '/tweets/:id' do
    tweet = Tweet.find(params[:id].to_i)
    redirect '/tweets' if tweet.user_id != current_user.id
    tweet.delete
    redirect '/tweets'
  end

  get '/tweets/:id/edit' do
    redirect '/login' unless logged_in?
    @tweet = Tweet.find(params[:id].to_i)
    erb :'tweets/edit'
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id].to_i)
    redirect "/tweets/#{@tweet.id}/edit" if params[:content].empty?
    @tweet.update(content: params[:content])
    redirect "tweets/#{@tweet.id}"
  end
end
