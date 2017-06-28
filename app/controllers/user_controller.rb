class UserController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :"users/signup"
    else
      redirect '/tweets'
    end
  end

  get '/login' do
    if !logged_in?
      erb :"users/login"
    else
      redirect '/tweets'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  post '/signup' do #creates and logs user in by adding user_id to session hash
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if @user.save
        session[:user_id] = @user.id
        redirect '/tweets'
      else
        redirect "/signup"
      end
    end
  end

  post '/login' do #logs user in by adding user_id to session hash
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect "/signup"
    end
  end

  get '/logout' do #logs user out by clearing session hash
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

end
