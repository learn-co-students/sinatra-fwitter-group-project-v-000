class UserController < ApplicationController

  get '/signup' do
    erb :"/users/create_user"
  end

  post '/signup' do
    if
      params.value?("")
       redirect to "/signup"
     else
       redirect to "/tweets"
    end
  end

end
