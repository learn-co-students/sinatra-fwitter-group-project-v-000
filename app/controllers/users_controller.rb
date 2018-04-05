class UsersController < Sinatra::Base

  get '/' do
    erb :index
  end

end
