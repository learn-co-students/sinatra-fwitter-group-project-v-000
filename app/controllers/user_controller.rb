class UserController < ApplicationController

  ### CREATE USER ###
  get '/users/new' do
    erb :'users/create_user'
  end

  post '/users/new' do
    if !params[username].empty? && !params[password].empty? && !params[email].empty?
      user = User.create(username: params[username], email: params[email], password_digest: params[password])
      redirect "/tweets/#{user.username}"
    else
      session[:failure] = "There was an error creating your account. Please try again."
      redirect "/users/new"
    end
  end

  ### LOGIN USER ###
  get '/users/login' do
    erb :'users/login'
  end

  post '/users/login' do 
    #veryify the username and password are entered and authenticated.
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets/#{user.username}"
    else
      session[:failure] = "There was an error logging in. Please try again."
      redirect
    #if neither then redirect back to login with flash message?
    erb :login
  end

end
