class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    if params.has_value?("")
      redirect to '/signup'
    else
      User.create(params)
    end
    redirect to '/tweets'
  end
end
