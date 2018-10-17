class UsersController < ApplicationController
    get '/signup' do 
        if logged_in?
          redirect "/tweets"
        else
         erb :"users/new"
        end
    end

    post '/signup' do 
        user = User.new(params)

        if user.save
            session[:user_id] = user.id
            redirect "/tweets"
        else
            redirect "/signup"
        end
    end

    get '/login' do 
        erb :'users/login'
    end

    post '/login' do 
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to '/tweets'
        else
            redirect to '/'
        end
    end

    get '/logout' do
        session.clear
        redirect to '/'
    end
end
