class UsersController < Sinatra::Base

  get '/' do
    erb :'/users/home'
  end
end
