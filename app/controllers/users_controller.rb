class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do #loads form to sign up
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to "/tweets"
    end
  end

  post '/signup' do
    if params[:username]== "" || params[:email]== "" || params[:password]== ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to "/tweets"
    end
    #submits a post request to sign up
    #logs the user in and adds user_id to sessions hash
    #redirect to home page
  end

  get '/login' do #loads form to log in
    if !logged_in?
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do #posts request to log in
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to '/signup'
    end
  end

end
