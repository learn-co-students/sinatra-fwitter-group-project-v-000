class UsersController < ApplicationController

    get '/signup' do
      erb :'/users/create_user'
    end

    post '/signup' do
      if params[:username] == "" || params[:password] == "" || params[:email] == "" && !helpers.logged_in?
        redirect to '/signup'
      else
        @user = User.create(username: params[:username], password_digest: params[:password], email: params[:email])
        @user.save
        session[:user_id] = params[:id]
        redirect to '/tweets'
      end
    end

end
