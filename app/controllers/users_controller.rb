class UsersController < ApplicationController

  get '/' do
    erb :index
  end

  get '/users/signup' do
    erb :'/users/signup'
  end

end
