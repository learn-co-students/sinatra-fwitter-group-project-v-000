class UsersController < ApplicationController
  get '/signup' do
    if (session[:id].nil?)
      erb :'users/signup'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if (params[:username].empty? || params[:password].empty? || params[:email].empty?)
      redirect '/signup'
    else
      user = User.create(params)
      session[:id] = user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    erb :'users/login'
  end

end
