class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            redirect to '/tweets'
        else
            erb :'users/create_user'
        end
    end

    post '/signup' do
          if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
              @user = User.create(params)
              @user.save
              session[:user_id] = @user.id
              redirect to '/tweets'
          else
              redirect to '/signup'
          end
      end

        get '/login' do
            if logged_in?
                redirect to '/tweets'
            else
                erb :'users/login'
            end
        end
        #receive the login form, find the user, and log the user in(create a session)
    post '/login' do
          #find the user
        @user = User.find_by(username: params[:username])
          #authenticate the user-verfy the user is who they say they are. the right credentials
        if @user.authenticate(params[:password])
        # log the user in - create the user session
        session[:user_id] = @user.slug #actually logging the user in.
          #redirect to the users show page
        puts session
        redirect "users/#{@user.slug}"
          #else
            #  redirect 'users/login'
          end
          #erb :login
      end

      get '/logout' do
          session.destroy
          redirect '/login'
      end

      get '/users/:slug' do
          "This will be the user show route"
          #@user = User.find_by_slug(params[:slug])
          #erb :'/users/show'
      end
end
