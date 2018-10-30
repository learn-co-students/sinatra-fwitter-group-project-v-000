class UsersController < ApplicationController

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/create_user'
  end

  post '/' do
    if params[:user][:username].empty? or params[:user][:email].empty? or params[:user][:password].empty?
      redirect '/signup'
    else
      user = User.create(params[:user])
      session[:id] = user.id
      redirect '/tweets'
    end
  end

end
