class UsersController < ApplicationController
  get '/signup' do
    erb :signup
  end

  post '/signup' do
    if !params[:username]
      redirect '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password])
      redirect '/tweets'
    end
  end

end
