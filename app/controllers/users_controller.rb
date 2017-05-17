class UsersController < ApplicationController
  get '/signup' do
    erb :'/users/create_users'
  end

end
