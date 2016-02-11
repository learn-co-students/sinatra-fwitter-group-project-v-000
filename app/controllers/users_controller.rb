class UsersController < ApplicationController

  get '/users/:slug' do
    erb :'users/show'
  end

end
