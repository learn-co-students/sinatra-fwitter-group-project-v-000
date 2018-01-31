class UsersController < ApplicationController

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    #get back infor from sign up form and add it here
  end

  get '/login' do
    erb :'users/login'
  end

##need to continue on with login steps and rest of user
end
