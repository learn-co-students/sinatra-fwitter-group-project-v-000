class UsersController < ApplicationController

    get '/signup' do
        if !logged_in?
            erb :'users/create_user'
        else
            redirect '/users'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect '/signup'
        end
        if !User.new(:username => params[:username], :password => params[:password]).valid?
            redirect to 'signup'
        elsif !User.new(:email => params[:email], :password => params[:password]).valid?
            redirect to 'signup'
        else
            @user = User.new(username: params[:username], email: params[:email], password: params[:password])
            @user.save
            session[:user_id] = @user.id
            redirect '/tweets'
        end
    end

    get '/login' do
        if !logged_in?
         erb :'users/login'
        else 
            redirect '/tweets'
        end
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/tweets'
        else
            redirect '/signup'
        end
    end

    get '/logout' do
        if logged_in?
            session.destroy
            redirect '/login'
        else 
            redirect '/'
        end
    end   
end

