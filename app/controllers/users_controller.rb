class UsersController < ApplicationController

  ######## SIGN UP #########
  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    redirect to "/tweets"
  end

  ######## LOG IN #########
  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    redirect to "/tweets"
  end

  ######## LOG OUT #########
  get '/logout' do
    redirect to "/login"
  end

end
