class UsersController < ApplicationController

  get '/' do
    erb :'/index'
  end

  get '/signup' do
      erb :'/users/create_users'
  end

  post '/signup' do
    binding.pry
  end

end
