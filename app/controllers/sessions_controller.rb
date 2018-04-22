require './config/environment'

class SessionsController < Sinatra::Base

    get '/signup' do 
        @session = session
        if session[:username] != nil
          redirect "/tweets/#{session[:username]}"
        else
          redirect '/sessions/signup'
        end
      end

      # get '/login' do
      #   erb :'/sessions/login'
      # end  

      post '/signup' do
        @user = User.create(username: params[:username], email:params[:email], password: params[:password])
        session[:username] = params[:username]
        redirect "/tweets/#{session[:username]}"
      end
    


end