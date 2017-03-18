require './config/environment'

class ApplicationController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "coffemug"
    end

    helpers do
        def logged_in?
            !session[:username].nil?
        end

        def current_user
            session[:username] 
        end
    end


    get '/' do
        erb :index
    end

    get '/signup' do
        erb :'/users/create_login'
    end

    post '/signup' do
        if !logged_in?
            if params[:username] != '' && params[:password] != '' && params[:email] != ''
                if !User.find_by(params[:username]) #usernam isn't used yet
                    @user = User.create(username: params[:username], password_digest: params[:password])
                    redirect '/success'
                else
                    # message = username already taken
                    redirect "/failure"
                end
            else
                #message = all fields must be filled out
                redirect "/failure"
            end
        else
            # logged in means you can't view sign up page
            redirect "/tweets"
        end
    end

    get '/login' do
        erb :"/users/login"
    end

    post '/login' do
        if params[:username] != '' && params[:password] != ''
            user = User.find_by(username: params[:username])
        end

        if !!(user && user.authenticate(params[:password]))

            session[:user_id] = user.id
            redirect '/success'
        else
            redirect '/failure'
        end
    end
    
    get "/success" do
        if logged_in?
            redirect '/account'
        else
            redirect "/login"
        end
    end

    get "/failure" do
        erb :failure
    end

    get "/logout" do
        session.clear
        redirect "/"
    end
    
    get "/tweets/:id/edit" do
    end
    
    get "/tweets/new" do
    end
    
    get "/tweets/:id" do
    end
    
    get "/tweets" do 
    end
    
    
    
    
end