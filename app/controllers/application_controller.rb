require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/twitter' do
    erb :'/tweets/tweets'
  end

  get '/signup' do
    erb :create_user
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      User.create(username: params[:username], email: params[:email], password: params[:password])
      redirect '/login'
    end
  end

  get '/login' do
    erb :'/users/login'
  end





end
