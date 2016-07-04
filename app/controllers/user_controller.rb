class UserController < ApplicationController

  get '/user' do
    erb :'users/login'
  end

end