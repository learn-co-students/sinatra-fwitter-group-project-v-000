#this is not being used due to the tests

class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect 'login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show_tweet'
    else
      redirect 'login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      current_user.tweets << Tweet.new(params)
      redirect '/tweets'
    end
      redirect '/tweets/new'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in? && current_user.id == @tweet.user.id
      erb :'tweets/edit_tweet'
    else
      redirect 'login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if !params[:content].empty?
      @tweet.update(content: params[:content])
    end
    redirect "/tweets/#{@tweet.id}/edit"
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet.user == current_user
      @tweet.destroy
    end
    redirect '/tweets'
  end

end