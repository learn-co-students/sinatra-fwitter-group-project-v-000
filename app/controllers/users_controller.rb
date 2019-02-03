class UsersController < ApplicationController

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    # binding.pry
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      # Could also use params.values.include?("")
      # Should do username and email validation here.
      # Could also use a flash message.
      redirect "/signup"
    end
    @user = User.create(params)
    # binding.pry
    session[:id] = @user.id
    redirect "/tweets"
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user = User.find(params[:id])
    # Log user in
    # Add user_id to sessions hash
    redirect "/"
  end

  get '/logout' do
    @user = User.find(params[:id])
    # Clear session hash
    redirect "/login"
  end

end
