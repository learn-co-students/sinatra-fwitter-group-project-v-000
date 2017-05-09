class UsersController < ApplicationController

  get '/signup' do
    if session[:id]
      redirect '/tweets'
    else
      erb :'/signup/new'
    end
  end

  post '/signup' do
    @user = User.create(params)

    if @user.save
      flash[:notice] = "Successfully created new user."
      session[:id] = @user.id

      redirect '/tweets'
    else
      flash[:error] = @user.errors.full_messages
      redirect '/signup'
    end
  end
end
