class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    @user = User.create(params)
    @user.save

    flash[:message] = "Successfully created User."
    redirect("/users/#{@user.id}")
  end


end
