class UsersController < ApplicationController


  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
    erb :'/users/signup'
    end
  end

  get '/login' do 
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end


  get '/users/:slug' do
    erb :'/users/show'
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user &&user.authenticate(params[:password])
      session[:user_id] = user[:id]
      redirect to '/tweets'
    else 
      redirect to '/login'
    end

  end
  
    get '/logout' do
      if logged_in?
        session.clear
        redirect to '/login'
      else
        redirect to '/'
      end
    end


end