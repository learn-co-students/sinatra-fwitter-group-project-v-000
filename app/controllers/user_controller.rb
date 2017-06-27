class UserController < ApplicationController

  get '/signup' do
    erb :"users/signup"
  end

  get '/login' do
    erb :"users/login"
  end

  post '/signup' do #creates and logs user in by adding user_id to session hash
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect "/"
    end
  end

  post '/login' do #logs user in by adding user_id to session hash
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect "/"
    end
  end

  post '/logout' do #logs user out by clearing session hash
    session.clear
    redirect "/"
  end

end
