class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do

    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    end

    @user = User.create(username:params[:username], email:params[:email], password:params[:password])
    session[:user_id] = @user.id
    redirect to "/tweets/tweets"
    
  end



end
