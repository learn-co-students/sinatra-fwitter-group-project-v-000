class TweetController < ApplicationController
  get '/tweets' do
    redirect '/login' unless session.key?(:user_id)
    @tweets = Tweet.all
    @username = User.find(session[:user_id]).username
    erb :'tweets/index'
  end

  get '/tweets/new' do
    redirect '/login' unless session.key?(:user_id)
    erb :'tweets/new'
  end

  post '/tweets' do
    redirect '/login' unless session.key?(:user_id)
    redirect '/tweets/new' if params[:content].empty?
    Tweet.create(content: params[:content], user_id: session[:user_id])
  end

  get '/tweets/:id' do
    redirect '/login' unless session.key?(:user_id)
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show'
  end

  get '/tweets/:id/edit' do
    redirect '/login' unless session.key?(:user_id)
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit'
  end

  patch '/tweets/:id' do
    redirect "/tweets/#{params[:id]}/edit" if params[:content].empty?
    tweet = Tweet.find(params[:id])
    tweet.update(content: params[:content])
  end

  delete '/tweets/:id/delete' do
    redirect '/tweets' unless session.key?(:user_id)
    tweet = Tweet.find(params[:id])
    redirect '/tweets' unless session[:user_id] == tweet.user_id
    tweet.delete
  end
end
