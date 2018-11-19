require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :homepage
  end 

  get '/signup' do
    erb :signup
  end

  post '/users' do 
    @user = User.create(params)
    redirect '/tweets/index'
  end

  get '/tweets/index' do 
    erb :'/tweets/index'
  end 

end
