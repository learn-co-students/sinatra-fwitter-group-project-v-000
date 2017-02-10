class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    user = User.create(params)
    if user.save
      session[:id] = user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

end
