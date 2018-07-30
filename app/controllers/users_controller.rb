class UsersController < ApplicationController

  get '/users/signup' do
    erb :'/signup'
  end

  post '/signup' do
    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    binding.pry
  end

end
