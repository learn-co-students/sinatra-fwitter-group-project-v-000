class UserController < ApplicationController

  get '/users/:user_slug' do
    @user = User.find_by(username: params[:user_slug])
    erb :'tweets/show_user'
  end


end