class UserController < ApplicationController

  get '/signup' do
    if is_logged_in?
      redirect("/tweets")
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do

    @user = User.create(params)
    if @user.valid?
      login(params[:username], params[:password])
      redirect("/tweets")
    else
      flash[:message] = "Invalid information entered.  Please fill out form completly"
      redirect("/signup")
    end
  end

  get '/login' do
    if !is_logged_in?
      erb :'/users/login'
    else
      redirect("/tweets")
    end
  end

  post '/login' do
    login(params[:username], params[:password])
    redirect("/tweets")
  end

  get '/logout' do
    logout!
    redirect("/login")
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end


end
