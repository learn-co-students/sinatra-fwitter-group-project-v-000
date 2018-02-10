class UserController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :"users/new"
    end
  end

  post '/signup' do
    @user = User.new(params)

    if user.save
        redirect "/login"
    else
        redirect "/failure"
    end
  end

end
