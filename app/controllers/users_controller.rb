class UsersController < ApplicationController

  get '/users/login' do
    erb :'/users/login'
  end

  get '/signup' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :signup
    end
  end

  get '/failure' do
    erb :failure
  end

  get '/login' do
    erb :'users/login'
  end

  post '/signup' do
      if params[:username] == "" || params[:email] == "" || params[:password] == ""
          redirect to "/signup"
      else
          @user = User.create(params)
          session[:user_id] = @user.id
          redirect to "/tweets"
        end
  end

end
