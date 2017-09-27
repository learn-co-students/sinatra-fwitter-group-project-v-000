class UsersController < Sinatra::Base

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do

  end

  end
end
