class LoginController < ApplicationController

    get '/login' do
      if authorize_home
        erb :"/authenticate/login"
      else
        redirect '/tweets'
      end
    end


    get '/signup' do
      if authorize_home
        erb :"/authenticate/signup"
      else
        redirect '/tweets'
      end
    end


    post '/login' do
      if ((user = User.find_by(username: params[:username])) && user.authenticate(params[:password]))
          session[:user_id] = user.id
          redirect '/tweets'
      else
          @error = "Improper credentials entered"
          # erb :"/authenticate/login"
          redirect '/login'
      end
    end

    post '/signup' do
      user = {name: params[:email], username: params[:username], password: params[:password], password_confirmation: params[:password]}
      new_user = User.new(user) #User.new(params[:user])
      if new_user.save
          session[:user_id] = new_user.id
          redirect '/tweets'
      else
          @errors = new_user.errors.messages
          redirect '/signup'
          # erb :"/authenticate/signup"
      end
    end

end
