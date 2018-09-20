class UsersController < ApplicationController

  get '/signup' do
     if !logged_in?
       erb :'users/create_user'
     else
       redirect to '/tweets'
     end
   end

  post '/signup' do
    @user = User.new
    @user.user_name = params[:user_name]
    @user.email = params[:email]
    @user.password_digest = params[:password]
    if @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      erb :'/signup'
    end
  end

end
