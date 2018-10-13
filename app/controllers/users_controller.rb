class UsersController < ApplicationController

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])

        erb :'/users/show'
    end

    post '/signup' do
        if !params.any?{|key, value| value == ""}
            @user = User.new(:username => params["username"], :email => params["email"], :password => params["password"])
            if @user.save
                session[:user_id] = @user.id
                flash[:message] = "Account was successfully created."
                
                redirect '/tweets'
            else
                flash[:message] = "Uh oh! Something went wrong. Please try again." 
                redirect '/index'
            end
        else
            flash[:message] = "Invalid information provided. All fields are required. Please try again." 
            redirect '/signup'
        end
    end

    post '/login' do
        session.clear
        @user = User.find_by(:username => params["username"])

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            flash[:message] = "Welcome, @user.username" 
            redirect '/tweets'
        else 
            redirect '/login'
        end
    end

    get '/signup' do
        if logged_in
            flash[:message] = "You have already created an account." 
            redirect '/tweets'
        else
            erb :'/users/create_user'
        end
    end

    get '/login' do
        if logged_in
            flash[:message] = "You are already logged in" 
            redirect '/tweets'
        else
            erb :'/users/login'
        end
    end

    get '/signup' do
        erb :'/users/create_user'
    end
      
    get '/logout' do
        if logged_in
            session.clear
            redirect '/login'
        else 
            flash[:message] = "You cannot log out if you weren't ever logged in!" 
            redirect '/'
        end
    end

    get '/logout' do
        if logged_in
            session.clear
            redirect '/login'
        else 
            flash[:message] = "You cannot log out if you weren't ever logged in!" 
            redirect '/'
        end
    end
end
