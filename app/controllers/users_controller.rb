class UsersController < ApplicationController

  get '/signup' do
    if User.logged_in?(session)
      redirect to '/tweets'
    else
      erb :"users/create_user"
    end
  end
  
  post '/signup' do
    if invalid_signup?
      # set a flash message here
      redirect to '/signup'
    else
      user = User.create(:email => params[:email], :username => params[:username], :password => params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    end
  end
  
  get '/login' do
    if User.logged_in?(session)
      redirect to '/tweets'
    else
      erb :"users/login"
    end
  end
  
  post '/login' do
    if invalid_login?
      #set a flash message here - fill out all three inputs
      redirect to '/login'
    else
      user = User.find_by(:username => params[:username])
      if !!user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect to '/tweets'
      else
        #set a flash message here - wrong password
        redirect to '/login'
      end
    end
  end
  
  get '/logout' do 
    if User.logged_in?(session)
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"users/show"
  end
  
  
  def invalid_signup?
    params[:email].empty? || params[:username].empty? || params[:password].empty?
  end
  
  def invalid_login?
    params[:username].empty? || params[:password].empty?
  end

end
