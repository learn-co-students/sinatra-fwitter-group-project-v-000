class UserController < ApplicationController

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    if !params.value?("")
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  
end
