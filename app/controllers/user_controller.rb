class UserController < ApplicationController
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