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

      post '/login' do
          @user = User.find_by(:username => params[:username])
          if @user
              session[:user_id] = @user.id
              redirect '/tweets'
          else
              redirect 'users/login'
          end
          erb :login
      end


      get '/logout' do
          session.destroy
          redirect '/login'
      end

      get 'user/:slug' do
          @user = User.find_by_slug(params[:slug])
          erb :'/users/show'
      end
end
