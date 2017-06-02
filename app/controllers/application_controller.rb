require './config/environment'
require "sinatra/reloader"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    register Sinatra::Reloader
    enable :reloader
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :homepage
  end

  get '/tweets' do
    logged_in? ? erb(:"tweet/list") : redirect('/login')
  end

  post '/tweets' do
    redirect('/login') unless logged_in?
    tweet = current_user.tweets.build(content: params[:content])
    tweet.save ? redirect('/tweets') : redirect('/tweets/new')
  end

  get '/tweets/new' do
    logged_in? ? erb(:"tweet/new") : redirect('/login')
  end

  get '/tweets/:tweet_id' do
    redirect('/login') unless logged_in?
    @tweet = Tweet.find(params[:tweet_id])
    erb :"tweet/show"
  end

  delete '/tweets/:tweet_id/delete' do
    redirect('/login') unless logged_in?
    tweet = Tweet.find(params[:tweet_id])
    tweet.delete if tweet.user == current_user
    redirect('/tweets')
  end

  get '/tweets/:tweet_id/edit' do
    redirect('/login') unless logged_in?
    @tweet = Tweet.find(params[:tweet_id])
    @tweet.user == current_user ? erb(:"tweet/edit") : redirect('/tweets')
  end

  post '/tweets/:tweet_id/edit' do
    tweet = Tweet.find(params[:tweet_id])
    redirect "/tweets/#{tweet.id}/edit" if params[:content] == ""
    tweet.update(content: params[:content])
    redirect "/tweets/#{tweet.id}"
  end

  get '/users/:user_slug' do
    @user = User.find_by_slug(params[:user_slug])
    erb :"users/show"
  end

  helpers do
    def logged_in?
      !!session[:id]
    end
    def current_user
      User.find(session[:id])
    end
  end
  
end