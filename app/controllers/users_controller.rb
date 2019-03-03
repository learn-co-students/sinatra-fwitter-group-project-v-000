class UsersController < ApplicationController

    get '/signup' do #renders the signup form
            erb :'users/create_user'
    end

    get '/login' do
        if logged_in?
            redirect to '/tweets'
        else
            erb :'users/login'
        end
    end

    post '/users' do
        if params[:username] != "" && params[:email] != "" && params[:password] != ""
            @user = User.create(params)
            #session[:user_id] = @user.id
             redirect to "/users/#{@user.id}"
         else
             #redirect to '/signup'
          end
    end

    post '/login' do
        #find the user
        @user = User.find_by(username: params[:username])
        #authenticate the user-verfy the user is who they say they are. the right credentials
        if @user.authenticate(params[:password])
            # log the user in - create the user session
            #session[:user_id] = @user.slug #actually logging the user in.
            #redirect to the users show page
            #puts session
            #redirect "users/#{@user.slug}"
            #else
            #  redirect 'users/login'
        end
        #erb :login
    end

    get '/users/:slug' do
        @user = User.find_by_slug(id: params[:slug])
        binding.pry
        erb :'/users/show'
    end

end
