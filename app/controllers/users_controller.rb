class UsersController < ApplicationController

  get '/users/login' do
    erb :'/users/login'
  end

  get '/signup' do
    erb :signup
  end

  get '/failure' do
    erb :failure
  end

  post '/signup' do
    unless session[:id] = ""
      redirect to "/tweets"
    end
      if params[:username] == "" || params[:email] == "" || params[:password] == ""
          redirect to "/signup"
      else
          @user = User.create(params)
          session[:id] = @user.id
          redirect to "/tweets"
        end
  end

end
