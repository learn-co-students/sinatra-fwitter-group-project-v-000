class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    end
    erb :"/users/create_user"
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    end
    erb :"/users/login"
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    else
      # binding.pry
      user = User.create(params)
      session[:user_id] = user.id
      redirect to "/tweets"
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username], :password => params[:password])
    session[:id] = @user.id
    redirect to '/tweets'
  end



  get '/logout' do
    session[:id].clear
    redirect to '/login'
  end

end
