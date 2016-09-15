class UserController < ApplicationController
  configure do
    set :views, '/app/views/users'
  end

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
