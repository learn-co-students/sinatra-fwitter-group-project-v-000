class LoginController < ApplicationController

    get '/login' do
        erb :"/authenticate/login"
    end

    get '/signup' do
        erb :"/authenticate/signup"
    end


    post '/login' do
        if ((user = User.find_by(username: params[:username])) && user.authenticate(params[:password]))
            session[:user_id] = user.id
            redirect '/'
        else
            @error = "Improper credentials entered"
            erb :"/authenticate/login"
        end
    end

    post '/signup' do
        new_user = User.new(params[:user])
        if new_user.save
            session[:user_id] = new_user.id
            redirect '/'
        else
            @errors = new_user.errors.messages
            erb :"/authenticate/signup"
        end

    end

end