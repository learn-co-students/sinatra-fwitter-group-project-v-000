class UsersController < ApplicationController
  use Rack::Flash


  get '/signup' do
    if !logged_in?
      flash[:message] = "Please Sign Up Before Log In"
      erb :'/users/create_user'
    else
    redirect '/tweets'
  end
end


  post '/signup' do

    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      flash[:message] = "Missing Information- Please Try Sign Up Again"
      redirect '/signup'
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        @user.save

        session[:user_id] = @user.id
        redirect '/tweets'
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
      redirect '/tweets'
    else
      flash[:message] = "Login Failed, Please Try Again"
      redirect '/signup'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
     erb :'/users/show'
  end


  get '/logout' do
    if logged_in?
    session.destroy
    redirect '/login'
    else
    redirect '/'
    end
  end





end
