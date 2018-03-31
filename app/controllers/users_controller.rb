class UsersController < ApplicationController

  get '/users/:slug' do
    if !logged_in?
      redirect to '/login'
    else
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    login(params[:username], params[:password])
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    elsif !!User.find_by(username: params[:username].downcase)
      @username_already_exists = true
      erb :'/users/signup'
    elsif !!User.find_by(email: params[:email])
      @email_already_exists = true
      erb :'/users/signup'
    else
      @user = User.create(username: params[:username].downcase, email: params[:email], password: params[:password])
      login(params[:username], params[:password])
    end
  end

  get '/logout' do
    if logged_in?
      logout!
    else
      redirect to '/login'
    end
  end

end
