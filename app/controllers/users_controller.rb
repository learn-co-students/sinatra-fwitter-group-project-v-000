class UsersController < ApplicationController

    # loads the signup page
    # if the user is not logged in, show them the sign up form
    # if the user is logged in, direct them to twitter index page
    get '/signup' do
        if !logged_in?
            erb :'/users/create_user'
        else
            redirect '/tweets'
        end
    end

    # loads the login page
    # if the user is not logged in, show them the login page
    # if the user is logged in, direct them to twitter index page
    get '/login' do
        if !logged_in?
            erb :'/users/login'
        else
            redirect '/tweets'
        end
    end

end
