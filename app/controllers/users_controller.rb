class UsersController < ApplicationController

  get '/users/slug' do
    @user = User.find_by(params[:slug])
    erb :'users/show'
  end


    get '/signup' do
      if !logged_in?
        erb :'/users/create_user'
        flash[:message] = "Welcome to Fwitter! Please sign up."
      else
        redirect to '/tweets'
      end
    end


end
