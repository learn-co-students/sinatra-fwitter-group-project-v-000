class UsersController < ApplicationController
#use Rack::Flash

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end


  get '/signup' do
    if !logged_in?
    #flash[:message] = "Welcome to Fwitter, please sign up."
    redirect to "users/create_user"
    else
      redirect '/tweets'
    end
  end

  post '/signup' do 
    #binding.pry
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      #flash[:message] = "Failure to log in".
      redirect to '/'
    end
  end


 get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end