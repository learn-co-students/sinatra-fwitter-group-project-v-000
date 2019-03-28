class UsersController < ApplicationController
    set :session_secret, "my_application_secret"
    set :views, Proc.new { File.join(root, "../views/") }

    get '/signup' do
        if !logged_in?
          erb :'users/signup'
        else
          redirect to ('/tweets')
        end
      end

    post '/signup' do
        if params[:username] == "" || params[:password] == "" || params[:email] == ""
            redirect to ('/signup')
        else
        @user = User.create(username: params[:username], password: params[:password], email: params[:email])
        @user.save
        session[:user_id] = @user.id
 
        redirect to ("/tweets")
        end
    end

end
