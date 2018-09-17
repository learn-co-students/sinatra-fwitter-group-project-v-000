class SessionsController < ApplicationController

  get '/login' do
    erb :"sessions/login.html"
  end

  post '/login' do
    login(params[:email])
    redirect '/posts'
  end

  get '/logout' do
    logout!!
    redirect '/login'
  end

end
