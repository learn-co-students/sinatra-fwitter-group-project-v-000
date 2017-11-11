# require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "spicy pickle"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'/signup'
  end

  post '/signup' do
    if !params[:username].empty? and !params[:email].empty? and !params[:password].empty?
      user = User.create(params)
    else
      redirect '/signup'
    end

    redirect '/tweets'
  end

  get '/login' do
    erb :'/login'
  end

  get '/tweets' do

    erb :tweets
  end

end
