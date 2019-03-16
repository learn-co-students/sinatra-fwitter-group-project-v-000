class UsersController < ApplicationController

  



  get '/logout' do
    if !session[:session_id].empty?
      session.clear
      redirect to '/login'
    end
  end

end
