class UsersController < ApplicationController

  get '/signup' do
    erb :"/users/create_user"
  end

  get '/signin' do
    erb :"/users/login"
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    end
    if User.find_by(:email => params[:email])
      redirect to '/signin'
    else
      user = User.create(params)
      redirect to '/tweets'
    end
  end

end
