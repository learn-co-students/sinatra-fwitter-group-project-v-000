class UserController < ApplicationController
    get '/login' do
        if logged_in?
            redirect to '/tweets'
        end

        session.delete(:login_error) ?
            @login_error_message = session.delete(:login_error_message) :
            @login_error_message = ''

        erb :'/users/login'
    end

    post '/login' do
        if params[:username].empty? 
            session[:login_error] = true
            session[:login_error_message] = "Please enter your username and try again"

        elsif params[:password].empty?
            session[:login_error] = true
            session[:login_error_message] = "Please enter your password and try again"
        end

        user = User.find_by(username: params[:username])
        
        if !user || !user.authenticate(params[:password])
            session[:login_error] = true
            session[:login_error_message] = "Check the username and password and try again"
        end

        session[:user_id] = user.id

        redirect to '/tweets'
    end

    get '/logout' do
        if logged_in?
            session.delete(:user_id)
            redirect to '/login'
        
        else
            redirect to '/'
        end
    end

    get '/signup' do
        if logged_in?
            redirect to '/tweets'
        end

        session.delete(:signup_error) ?
            @signup_error_message = 'All fields are required!' :
            @signup_error_message = ''

        erb :'/users/new'
    end
    
    post '/signup' do
        if params[:username].empty? || params[:password].empty? || params[:email].empty?
            session[:signup_error] = true
            redirect to '/signup'

        else 
            user = User.create(
                username: params[:username],
                password: params[:password],
                email: params[:email]
            )
            session[:user_id] = user.id

            redirect to '/tweets'
        end
    end
end