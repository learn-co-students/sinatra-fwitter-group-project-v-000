class SessionsController < ApplicationController

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect "/tweets/#{User.find_by(username: session[:username]).slug}}"
    else
      erb :"/sessions/signup"
    end
  end

    get '/login' do
      if logged_in?
        redirect "/tweets"
      else
        erb :"/sessions/login"
      end
    end

    get '/logout' do
      session.clear
      redirect '/login'
    end

  post '/signup' do
    if params[:username]=="" || params[:email]=="" || params[:password]==""
      redirect "/signup"
    else
      @user = User.create(username: params[:username], email:params[:email], password: params[:password])
      session[:username] = params[:username]
      redirect "/tweets"
    end
  end


  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user==nil
      redirect "/signup"
    else
      session[:username] = params[:username]
      redirect "/tweets"
    end
  end


end
