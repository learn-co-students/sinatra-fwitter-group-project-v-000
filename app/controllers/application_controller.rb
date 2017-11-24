require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'user/create_user'
  end

  get '/login' do
    erb :'user/login'
  end

  get '/logout' do
    erb :index
  end

  get '/tweets/new' do

    erb :"tweet/create_tweet"
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(id: params['id'])
    erb :"tweets/show_tweet"
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params['id'])
    erb :"tweet/edit_tweet"
  end

  post '/signup' do
    redirect to
  end

  post '/login' do
    redirect to
  end

  post '/tweets' do
    redirect to "tweets/show"
  end

  post '/tweets/:id'do
    @tweet = Tweet.find_by(id: params['id'])
    redirect to "tweets/show"
  end

end
