class UsersController < ApplicationController
  
  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'signup'
    end
  end 

  get "/login" do
    if logged_in?
      redirect to '/tweets'
    else
      erb :login
    end
  end

  post '/signup' do 
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
    else
      @user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])
      if @user.save
        @user.save
        session[:user_id] = @user.id
        redirect "/tweets"
      else
        redirect "/signup"
      end
    end
  end

  post "/login" do
    @user = User.find_by(:username => params[:username])
    if params[:username] == "" || params[:password] == ""
      redirect '/login'
    elsif @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    end
    redirect '/login'
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'show'
  end

end