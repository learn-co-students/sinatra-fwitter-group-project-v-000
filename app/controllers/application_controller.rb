require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/create_users'
  end

  post '/signup' do
    user = User.new(params[:user])
    if user.save
      redirect '/login'  #change this to redirect directly to index page with user logged in
    else
      redirect '/signup'
      #todo: implement a rack flash message saying date not valid or somesuch
    end
  end

  get '/login' do
    erb: 'users/login'
  end



end
