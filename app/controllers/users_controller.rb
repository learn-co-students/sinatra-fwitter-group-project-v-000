class UsersController < ApplicationController
  get '/signup' do
    if !session[:id]
      erb :"/users/create_user"
    else
      redirect("/tweets")
    end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      user = User.create(params)
      session[:id] = user.id
      redirect("/tweets")
    else
      redirect("/signup")
    end
  end

  get '/login' do
    erb :"/users/login"
  end

  post '/login' do
    user = User.find_by(params)
    session[:id] = user.id
    redirect("/tweets")
  end

  get '/logout' do
    session.clear
    redirect("/")
  end

end
