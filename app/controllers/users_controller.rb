class UsersController < ApplicationController

  # loads the signup page
  # does not let a logged in user view the signup page
  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/create_user'
    end
  end

  # does not let a user sign up without a username
  # does not let a user sign up without an email
  # does not let a user sign up without a password
  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    end
    @user = User.create(username:params[:username], email:params[:email], password:params[:password])
    session[:user_id] = @user.id
    redirect to "/tweets"
  end

  # loads the login page
  # loads the tweets index after login
  # does not let user view login page if already logged in
  # does load /tweets if user is logged in
  # lets a user view the tweets index if logged in
  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username:params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  # shows all a single users tweets
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  # lets a user logout if they are already logged in
  # does not let a user logout if not logged in
  # does not let a user view the tweets index if not logged in
  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
