require 'rack-flash'
class UsersController < ApplicationController
  enable :sessions
  use Rack::Flash

  get '/signup' do 
    if !logged_in?
      erb :"users/create_user"
    else
      redirect "/tweets"
    end
  end

  post '/signup' do
     @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      flash[:error] = "Please fill out all the required fields"
      redirect "/signup"
    end
  end


  get '/login' do
    if !logged_in?
       erb :'/users/login'
    else
       redirect to '/tweets'
    end
  end

  post '/login' do
    #user = User.find(current_user.id) 
    user = User.find_by(:username => params[:username])
     user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
  end

  get '/users/:id' do 
    @user = User.find(params[:id])
    erb :"/users/show"
  end

  get '/logout' do
    if logged_in?
       session.clear
       redirect to '/login'
    else
      redirect '/'
     end

  end

end

