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
    if !session[:id]
      erb :"/users/login"
    else
      redirect("/tweets")
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:id] = user.id
      end
    redirect("/tweets")
  end

  get '/logout' do
    if session[:id]
      session.clear
    end
    redirect to '/login'
  end

end
