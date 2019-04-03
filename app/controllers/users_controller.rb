class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/signup' do
    if logged_in?
    redirect '/tweets'
    else
    erb :'/users/signup'
  end
  end





  get '/login' do
    if logged_in?
      redirect '/tweets'
    end
      erb :'/users/login'
  end



  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    else
    @user = User.create(:username=> params[:username], :email=> params[:email], :password_digest=> params[:password])
    session[:id] = @user.id
    redirect '/tweets'
  end
  end

  post '/login' do
    user = User.find_by(:username=> params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
    redirect '/tweets'
    else
    redirect '/login'
  end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end


end
