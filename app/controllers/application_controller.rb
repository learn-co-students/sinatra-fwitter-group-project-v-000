require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/tweets/new' do

  end

  post '/tweets' do

  end

  get '/tweet/:id' do

  end

  get '/tweet/:id/edit' do

  end

  patch '/tweet/:id' do

  end

  post '/tweet/:id/delete' do

  end

  get '/signup' do

  end

  post '/signup' do

  end

  get '/login' do

  end

  post '/login' do

  end

  post '/logout' do
    
  end
end
