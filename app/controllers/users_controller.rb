class UsersController < ApplicationController

    get '/signup' do
        if is_logged_in?
        redirect '/tweets'
        else
        erb :'/users/signup'
        end
    end

    post '/signup' do
        user = User.new(username:params[:username], email:params[:email], password:params[:password])
        if user.save && user.username != " " && user.email != " "
            session[:user_id] = user_id 
        else
           redirect to '/signup'
        end
    #   redirect to '/tweets'  
    end 


end
