require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "coffemug"
    end

    helpers do
        def logged_in?
#            binding.pry
            !session[:id].nil?
        end

        def current_user
            session[:id] 
        end
    end


    get '/' do
        erb :index
    end

    get '/signup' do
#        binding.pry
        if !logged_in?
            erb :'/users/create_login'
        else
            redirect '/tweets'
        end
    end

    post '/signup' do
        #                binding.pry
        if !logged_in?
            if params[:username] != '' && params[:password] != '' && params[:email] != ''
                if !User.find_by(username: params[:username]) #usernam isn't used yet
                    @user = User.create(params)
                    session[:user_id] = @user.id
                    redirect '/tweets'
                else
                    # message = username already taken
                    redirect "/signup"
                end
            else
                #message = all fields must be filled out
                redirect "/signup"
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
        binding.pry
        if logged_in?
            redirect '/tweets'
        else
            redirect "/login"
        end
    end

    get "/failure" do
        erb :"index"
    end

    get "/logout" do
        session.clear
        redirect "/"
    end

    get "/tweets/:id/edit" do
        erb :"tweets/edit_tweet"
    end

    get "/tweets/new" do
        erb :"tweets/create_tweet"
    end

    get "/tweets/:id" do
        erb :"tweets/show_tweet"
    end

    get "/tweets" do 
        erb :"tweets/tweets"
    end




end