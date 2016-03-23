class UserController < ApplicationController
  get '/' do
    erb :index
  end

  get '/signup' do
    erb :index
  end

  get '/login' do
    erb :'/tweets/tweets'
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect '/signup'
    else
      User.create(username: params[:username], password: params[:password])
      redirect '/tweets/tweets'
    end
  end
end
