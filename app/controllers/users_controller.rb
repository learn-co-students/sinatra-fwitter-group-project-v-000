class UsersController < ApplicationController

  get '/signup' do
    if !!session[:id]
      redirect to "/tweets"
    else 
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params.has_value?("")
      redirect to "/signup"
    else
      @user = User.create(params)
      session[:id] = @user.id
      redirect to "/tweets"
    end
  end

end
