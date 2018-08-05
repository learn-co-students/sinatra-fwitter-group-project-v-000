class UsersController < ApplicationController

  get '/registrations/signup' do
    erb :'users/signup'
  end

  get '/users/home' do
    binding.pry
    @user = User.find_by_id(params[:id])
    erb :'users/home'
  end

  post '/registrations' do
    @user = User.create(params[:user])
    session["session_id"] = @user.id
    redirect '/users/home'
  end

end
