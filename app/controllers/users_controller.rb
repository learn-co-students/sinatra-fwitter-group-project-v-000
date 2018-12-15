class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
    erb :'/users/create_user'
  else
    redirect to '/tweets'
    end
  end

  post '/signup' do
    if params[:user][:password] == "" || params[:user][:email] == "" || params[:user][:username] == ""
      redirect to '/signup'
    else
      @user = User.create(params[:user])
      session[:user_id] = @user.id
      redirect to '/tweets'
    end



  end

end
