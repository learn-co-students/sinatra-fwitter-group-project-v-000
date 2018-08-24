class UsersController < ApplicationController

    # loads the signup page
    # if the user is not logged in, direct them the sign up form
    # if the user is logged in, redirect them to twitter index page
    get '/signup' do
        if !logged_in?
            erb :'/users/create_user'
        else
            redirect '/tweets'
        end
    end

    # loads the login page
    # if the user is not logged in, direct them the login page
    # if the user is logged in, redirect them to twitter index page
    get '/login' do
        if !logged_in?
            erb :'/users/login'
        else
            redirect '/tweets'
        end
    end

    # submits the signup form
    # if there is a blank input, redirect them back to sign up
    # if user creates their sign in info with three params, redirect to twitter index page
    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect '/signup'
        else
            @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
            @user.save
            session[:user_id] = @user.id
            redirect '/tweets'
        end
    end

end
