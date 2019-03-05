class UsersController < ApplicationController

# Registers/signup
    get '/signup' do #renders the signup form
        if logged_in?
            redirect to '/tweets'
        else
            erb :'users/create_user'
        end
    end

    post '/signup' do
        if params[:username] != "" && params[:email] != "" && params[:password] != ""
            @user = User.create(params)
            @user.save
            session[:user_id] = @user.id
             redirect to '/tweets'
         else
             redirect to '/signup'
          end
    end

    get '/login' do #log user in
        if logged_in?
            redirect to '/tweets'
        else
            erb :'users/login'
        end
    end

    post '/login' do
        #find the user
        @user = User.find_by(username: params[:username])
        #binding.pry
        #authenticate the user-verfy the user is who they say they are. the right credentials
        if @user && @user.authenticate(params[:password])
            # log the user in - create the user session
            session[:user_id] = @user.id #actually logging the user in.
            #redirect to the users show page
            #puts session
            redirect to '/tweets'
            else
              erb  :'users/login'
        end

    end

    get '/logout' do# user log out
        if logged_in?
            session.destroy
            redirect to '/login'
        else
            redirect to '/'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end
end
