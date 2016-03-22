require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end



  get '/signup' do
    erb :index
  end

  post '/signup' do
    redirect "/tweets"
  end

  get '/login' do
    erb :"tweets/users/login"
  end

  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do


  end

end