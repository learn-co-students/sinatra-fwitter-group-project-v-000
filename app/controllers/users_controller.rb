class UsersController < ApplicationController 

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else 
      redirect to '/tweets'
    end
  end

  post '/signup' do 
   @user = User.new(username: params["username"], email: params["email"], password: params["password"])
   @user.save
    if session[:id] = @user.id
      redirect '/tweets'
    else 
      redirect '/signup'
    end
  end

  get '/login' do 
    if !logged_in?
      erb :'/users/login'
    else 
      redirect '/tweets'
    end
  end 

  post '/login' do 
    user = User.find_by(username: params[:username])
    user && user.authenticate([:password])
    session[:id] = user.id
    redirect '/tweets'
  end

  get '/logout' do 
    if logged_in?
      session.destroy
      redirect to '/login'
    else 
      redirect to '/'
    end
  end

  get "/users/:slug" do 
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end


end