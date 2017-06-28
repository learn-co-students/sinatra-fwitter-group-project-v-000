class UsersController < ApplicationController
  get '/signup' do
    erb :"/users/create_user"
  end

  post '/signup' do
    redirect("/tweets")
  end

  get '/login' do
    erb :"/users/login"
  end

  post '/login' do
    redirect("/tweets")
  end

  get '/logout' do
    session.clear
    redirect("/")
  end

end
