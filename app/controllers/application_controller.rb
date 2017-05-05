require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :home
  end

  get '/singup' do
    erb :singup
  end

  get '/login' do
    erb :login
  end

  get '/failure' do
    erb :failure
  end

  post '/singup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      redirect to "/tweets"
    else
      redirect to "/failure"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/failure"
    end
  end

  get '/logout' do
    session.clear
    redirect to "/"
  end

end
