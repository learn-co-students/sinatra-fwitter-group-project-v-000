class UsersController < ApplicationController
  get '/signup' do
    if !logged_in?
      erb :'/users/create_user', locals: {message: "Please sign up before you sign in"}
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    else
      @user = User.create(params[:user])
      session[:user_id]=@user.id
      redirect to '/tweets'
    end
  end

end
