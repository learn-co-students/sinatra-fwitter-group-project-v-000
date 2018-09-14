class UsersController < ApplicationController

    get '/signup' do
      erb :'/users/create_user'
    end

    post '/signup' do
      @user = User.new(username: params[:username], password_digest: params[:password], email: params[:email])
      if params[:username] == "" || params[:password] == "" || params[:email] == "" || @user.logged_in?
      else
        @user.save
        session[:user_id] = params[:id]
        redirect '/tweets'
      end
    end

end
