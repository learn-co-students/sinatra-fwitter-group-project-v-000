class UsersController < ApplicationController

  get '/' do
    erb :index
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    login(params[:email], params[:password])
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    if !!User.find_by(username: params[:username].downcase)
      @username_already_exists = true
      erb :signup
    elsif !!User.find_by(email: params[:email])
      @email_already_exists = true
      erb :signup
    else
      @user = User.create(username: params[:username].downcase, email: params[:email], password: params[:password])
      login(params[:email], params[:password])
    end
  end

  get '/logout' do
    logout!
  end

end
