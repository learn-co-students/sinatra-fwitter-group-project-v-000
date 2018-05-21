class UsersController < ApplicationController

  get '/signup' do
    if logged_in? #doesn't load signup page if user is logged in
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      #add || to check if email includes @ + .com?
      flash[:message] = "Please enter all fields with required information"
      redirect '/signup'
    else
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'songs/show'
  end

  get '/login' do
    if logged_in? #doesn't load signup page if user is logged in
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      flash[:message] = "Login information incorrect"
      redirect to '/login'
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end


end
