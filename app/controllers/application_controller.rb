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
    #erb
  end

  post '/signup' do

  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do

  end

  get '/logout' do

  end

  post '/logout' do

  end

  get '/tweets' do
    erb :'tweets/tweets'
  end

  get '/users/:user_slug' do
    #@user =
    #erb
  end

  get '/tweets/new' do
    erb :'tweets/create_tweet'
  end

  post '/tweets/new' do

  end

  get '/tweets/:tweet_id' do
    erb :'tweets/show_tweet'
  end

  get '/tweets/:tweet_id/edit' do
    erb :'tweets/edit_tweet'
  end

  post '/tweets/:tweet_id' do

  end

  post '/tweets/:tweet_id/delete' do

  end

end