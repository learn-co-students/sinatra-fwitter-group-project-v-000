require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :layout
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
end