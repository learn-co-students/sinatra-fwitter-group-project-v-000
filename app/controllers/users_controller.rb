class UsersController < ApplicationController

    get '/signup' do
        if Helper.logged_in?(session)
            redirect '/tweets'
        end
        erb :'/users/signup'
    end

    post '/signup' do
            params.each do |label, input|
            if input.empty?
              flash[:new_user_error] = "Please enter a value for #{label}"
              redirect '/signup'
            end
          end
        @user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
        session[:user_id] = @user.id
        redirect '/tweets'
    end

    get '/login' do
        if Helper.logged_in?(session)
            redirect '/tweets'
        end
        erb :'users/login'
    end

    post '/login' do
        @user = User.find_by(:username => params["username"])
        session[:user_id] = @user.id
        redirect '/tweets'
    end

    get '/logout' do
        session.clear
        redirect '/login'
    end

    get '/users/:id' do
        @user = User.find_by_id(params["id"])
        erb :'/users/show'
    end


end
