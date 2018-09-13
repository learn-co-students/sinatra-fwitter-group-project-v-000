class UsersController < ApplicationController

    get '/signup' do
      erb :'/users/create_user'
    end

    post '/signup' do
      if params[:username] == "" || params[:password] == "" || params[:email] == ""
        redirect to '/signup'
      else
        @user = User.create(username: params[:username], password: params[:password], email: params[:email])
        @user.save
        helper.login(params[:email])
        sessions[:user_id] = params[:id]
      end
    end

end
