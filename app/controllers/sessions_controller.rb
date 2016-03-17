class SessionsController < ApplicationController


  get '/' do
    if logged_in?
      @user = User.find_by_id(session[:id])
    end
    erb :home
  end


  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'registrations/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'sessions/login'
    end
  end

  get '/logout' do
    if logged_in?
      logout!
      redirect '/login'
    else
      redirect '/'
    end
  end

  post '/login' do
    binding.pry
    @user = User.find_by(username: params[:username])
      session[:id] = @user.id
      erb 'tweets/tweets'
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup', locals: {message: "You must fill in all fields."}
    else
      user = User.create(username: params[:username], password: params[:password], email: params[:email])
      session[:id] = user.id
      redirect to '/tweets'
    end
  end


end
