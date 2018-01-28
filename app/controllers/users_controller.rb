class UsersController < ApplicationController

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    if params.all? {|key, value| value != ""}
      user = User.new(params)
      user.save
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end




end
