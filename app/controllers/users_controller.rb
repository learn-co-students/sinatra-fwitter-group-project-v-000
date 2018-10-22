class UsersController < ApplicationController
    
    get '/signup' do
        if !logged_in?
            erb :'users/create_user'
        else
            redirect to '/tweets'
        end
    end

    post '/signup' do
        user_emails = User.all.collect {|user| user.email}
        usernames = User.all.collect {|user| user.username}

        if user_emails.include?(params[:email]) || usernames.include?(params[:username]) || params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to '/signup'
        else
            @user = User.create(username: params[:username], email: params[:email], password: params[:password])
            session[:user_id] = @user.id
            redirect to '/tweets'
        end
    end

    get '/login' do
        if logged_in?
            redirect to '/tweets'
        else
            erb :'users/login'
        end
    end

    post '/login' do
        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to '/tweets'
        else
            redirect to '/signup'
        end
    end

    get '/logout' do
        session.clear
        redirect "/login"
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end

end

