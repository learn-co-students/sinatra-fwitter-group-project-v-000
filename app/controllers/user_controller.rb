class UserController < ApplicationController
  configure do
    set :views, '/app/views/users'
  end

  get '/' do
    erb :signup
  end
end
