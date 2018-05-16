class UsersController < ApplicationController
    get '/signup' do
        if Helpers.logged_in?(session)
           redirect '/tweets'
        else
            erb :'/users/create_user'
        end
    end
    
    post '/signup' do
        if params[:username].empty? || params[:email].empty? || params[:password].empty?
            redirect '/signup'
        end
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])

        if @user.save
            session[:user_id] = @user.id
            redirect '/tweets'
        else
            redirect "/failure"
        end
    end
    
    get '/login' do
        if Helpers.logged_in?(session)
           redirect '/tweets'
        else
            erb :'/users/login'
        end
    end
    
    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/tweets'
        else
            redirect '/login'
        end
    end
    
    get '/logout' do
        if Helpers.logged_in?(session)
            session.clear
            redirect '/login'
        end
        redirect '/'
    end
    
    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end
end