require './config/environment'

class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    erb :'/users/show'
  end

  ##login
  ##sessions
  ##user_id


end
