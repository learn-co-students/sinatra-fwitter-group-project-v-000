class UsersController < ApplicationController

  get '/users/:slug' do
    erb :'show'
  end
end
