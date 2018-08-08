class UsersController < ApplicationController

  get '/' do
    erb :'/users/home'
  end

  get '/login' do
    erb :'/users/login'
  end

end
