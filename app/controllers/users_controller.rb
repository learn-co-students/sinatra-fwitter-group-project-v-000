class UsersController < ApplicationController

  get '/' do
    erb :'/users/home'
  end

  get '/signup' do
    erb :'/users/signup'
  end
end
