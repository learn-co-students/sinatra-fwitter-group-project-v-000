#This is not being used due to the tests

class UserController < ApplicationController

  get '/signup' do
    if logged_in?
     redirect to '/tweets' 
   else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    # if !User.find_by(username: params[:username]) && !User.find_by(email: params[:email])
      user = User.new(params)
    # else
      # user = User.new
    # end
    if user.save
      session[:id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username]) 
    if !!user && user.authenticate(params[:password])
      session[:id] = user.id
    end
    redirect "/tweets"
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end