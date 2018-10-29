class UsersController < ApplicationController


  get '/signup' do
   if logged_in?
    redirect to "/tweets"
   else
    erb :'/signup'
   end
  end

  post '/signup' do
    if params[:username] == ""|| params[:email] == "" || params[:password] == ""
      redirect to :"/signup"
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save

      session[:user_id] =@user.id

      redirect to :"/tweets"
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/login'
    else
      redirect to '/tweets'
    end
  end


end
