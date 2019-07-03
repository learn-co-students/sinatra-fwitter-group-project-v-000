class UsersController < ApplicationController

    get '/users/:slug' do
        @current_user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end
    
    get '/signup' do
       # binding.pry
        if !is_logged_in?  
            erb :'/users/signup'
        else
            redirect to '/tweets'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to '/signup'
        else        
            @current_user = User.new(username: params[:username], email: params[:email], password: params[:password])
            @current_user.save
            session[:user_id] = @current_user.id
            redirect to '/tweets'
        end
    end

    get '/login' do
        if !is_logged_in?
            erb :'/users/login'
        else
            redirect to '/tweets'
        end
    end

    post '/login' do
        @current_user = User.find_by(:username => params[:username])
       # binding.pry
        if @current_user && @current_user.authenticate(params[:password])
            session[:user_id] = @current_user.id
          #  binding.pry
            redirect to '/tweets/tweets'
        else
            redirect to '/signup'
        end
    end

    get '/logout' do
        session.clear
        redirect to '/login'
    end

    

end
