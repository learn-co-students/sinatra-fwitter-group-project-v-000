class AuthenticationsController < ApplicationController

  get '/' do
    if logged_in?
      @user = current_user
      erb :"/users/show"
    else
      erb :index
    end
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user', locals: {message: "Please sign up before you sign in"}
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if nil_submission?
      redirect to '/signup'
    else
      @user = User.new(:username => params["username"], :email => params["email"], :password => params["password"])
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end


  get '/login' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :"/users/login"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      @login_error = true
      erb :"/users/login"
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end


end
