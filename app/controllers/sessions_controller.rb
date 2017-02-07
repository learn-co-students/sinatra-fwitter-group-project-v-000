class SessionsController < ApplicationController
  use Rack::Flash

  get '/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    login
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end
end
