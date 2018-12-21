class UsersController < ApplicationController

  get '/signup' do

    erb :'/users/create_user'
  end

  post '/signup' do

    redirect to '/users/show'
  end

  get '/users/show' do

    erb :'/users/show'
  end

  get '/login' do

    erb :'/users/login'
  end

  post '/login' do


  end


end
