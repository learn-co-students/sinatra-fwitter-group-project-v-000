class UserController < ApplicationController
  
  get '/' do
    erb :signup
  end

  get '/login' do
    erb :login
  end

  get '/account' do
    erb :accounts
  end

end
