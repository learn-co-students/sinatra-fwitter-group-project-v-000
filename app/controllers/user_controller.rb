class UserController < ApplicationController
  get '/signup' do
    erb :create_users
  end

  post '/signup' do

    redirect '/tweets'
  end

  get '/login' do
  end

  post '/login' do
  end

  get '/logout' do
    session.clear
  end

  get '/' do
  end
end