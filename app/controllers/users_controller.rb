class UsersController < ApplicationController


  get 'users/signup' do

    erb :'/users/signup'
  end

  post '/users/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password_digest])
    @user.save

    redirect to :"/tweets"
  end

end
