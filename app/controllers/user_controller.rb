class UserController < ApplicationController

  get '/signup' do
    erb :"users/create_user"
  end

  get '/login' do
    erb :"users/login"
  end

  post '/login' do
    binding.pry
    @user = User.find_by(username: params[:username], password: params[:password])
    erb :"users/show"
  end

  # get '/logout' do
  #   erb :"users/"
  # end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(params)
      session[:user_id] = @user.id
    redirect '/tweets'
    else
    redirect "/signup"
    end
  end

end
