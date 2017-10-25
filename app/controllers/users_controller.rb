class UsersController < ApplicationController
  
  get('/login') {if logged_in?; redirect to "/tweets" else erb :login end}

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      login(@user.id)
      redirect '/tweets'
    else
      erb :login
    end
  end

  get('/logout') {if logged_in?; logout; redirect to "/login" else redirect to "/" end}

  get('/signup') {if logged_in?; redirect to "/tweets" else erb :signup end}

  post '/signup' do 
    @user = User.create(params)
    if @user.save
      login(@user.id)
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/user_show"
  end

end