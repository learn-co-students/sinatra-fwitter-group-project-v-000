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

end

