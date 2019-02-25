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


end
