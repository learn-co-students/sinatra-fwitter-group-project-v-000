class UsersController < ApplicationController

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    "Post /signup- success -> show public /tweets otherwise back to get signup"
  end

end
