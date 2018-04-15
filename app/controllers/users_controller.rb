class UsersController < ApplicationController

  get '/signup' do #sign up the user, if a user isn't logged in
    if !logged_in?
      erb :"users/signup"
    else
      redirect '/tweets'
    end
  end

  post '/signup' do #create a new user with inputs or send them back to sign up page if any field is blank
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    else
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/login' do #if user isn't logged in bring them to the login page
    if !logged_in?
      erb :'/users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    #find the user, make sure the user and their password matches, save the user id ot the session
    #if not, bring them to the login page
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do #allows user to log out if they are already logged in
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do #shows all of a users tweets
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end
