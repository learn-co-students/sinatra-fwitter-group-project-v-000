class TweetsController < ApplicationController
  enable :sessions
  set :session_secret, 'fwitter'
  set :public_folder, 'public'
  set :views, 'app/views'


  get '/tweets' do
    redirect '/login' if !logged_in?
    erb :'/tweets/tweets'
  end

  post '/tweets' do
    redirect '/login' if !logged_in?
    redirect '/tweets/new' if params[:tweet][:content].empty?
    @tweet = Tweet.create(params[:tweet])
    @tweet.user_id = User.find_by(username: current_user).id
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end

  get '/tweets/new' do
    redirect '/login' if !logged_in?
    erb :'/tweets/new'
  end

  get '/tweets/:id' do
    redirect '/login' if !logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
  end
end
