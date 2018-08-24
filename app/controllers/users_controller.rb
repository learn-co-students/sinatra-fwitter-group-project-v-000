class UsersController < ApplicationController

    get '/signup' do
        if !logged_in?
            erb :'/users/create_user'
        else
            redirect '/tweets'
        end
    end

end
