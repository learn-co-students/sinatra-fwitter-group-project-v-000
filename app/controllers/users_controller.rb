class UsersController < ApplicationController
  get '/' do
    erb :'users/homepage'
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to 'tweets'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if user.save
      session[:user_id] = user.id
      redirect to 'tweets'
    else
      redirect to 'signup'
    end
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect to 'tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to 'tweets'
    else
      redirect to 'login'
    end
  end

  get '/logout' do
    session.clear
    redirect 'login'
  end

  get '/users/:slug' do
    @user = Helpers.current_user(session)
    @tweets = @user.tweets.all
    erb :'users/show'
  end
end
