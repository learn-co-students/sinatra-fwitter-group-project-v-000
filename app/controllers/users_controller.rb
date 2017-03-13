class UsersController < ApplicationController

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
    erb :'users/login'
    end
  end

  post '/login' do
     user = User.find_by(username: params[:username])
     if user && user.authenticate(params[:password])
       session[:user_id] = user.id
       redirect '/tweets'
     else
       redirect "/signup"
     end
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
    erb :'users/create_user'
    end
  end


  post '/signup' do
    if params[:username] == '' || params[:email] == '' || params[:password] == ''
      redirect "/signup"
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

  get '/logout' do
    if !logged_in?
      redirect '/'
    else
      session.clear
      redirect '/login'
    end
  end


  get '/users/:slug' do
    if !logged_in?
      redirect '/login'
    else
    #  @user = User.find_by_slug(params[:slug])
    #end
    #@user = User.find_by_slug(params[:slug])
    erb :'users/show'
    end
  end

end
