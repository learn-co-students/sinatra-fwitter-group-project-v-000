class UsersController < ApplicationController

  get '/users/:slug' do #user page request
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end

  get '/signup' do #signup page request
    if !is_logged_in?
      erb :signup
    else
      redirect :"/tweets"
    end
  end

  post '/signup' do #signup and redirect
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect :"/signup"
    else
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:user_id] = @user.id
      redirect :"/tweets"
    end
  end

  get '/login' do #login page request
    if !is_logged_in?
      erb :login
    else
      redirect :'/tweets'
    end
  end

  post "/login" do #login and redirect
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect :"/tweets"
    else
      redirect :"/signup"
    end
  end

  get '/logout' do #logout
    session.clear
    redirect :"/login"
  end

end
