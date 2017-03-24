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

        if logged_in?
            redirect '/tweets'  
        else
            erb :'/users/create_login'
        end
    end

    post '/signup' do
        if !logged_in?
            if params[:username] != '' && params[:password] != '' && params[:email] != ''
                @user = User.create(params)
                session[:id] = @user.id
                redirect '/tweets'
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
        if logged_in?
            redirect "/tweets"
        else
            erb :"/users/login"
        end
    end

    post '/login' do

        if params[:username] != '' && params[:password] != ''
            user = User.find_by(username: params[:username])
        end
        if !!(user && user.authenticate(params[:password]))
            session[:id] = user.id
            redirect '/tweets'
        else
            redirect '/login'
        end
    end

    get "/logout" do
        session.clear
        redirect "/login"
    end
    post "/tweets/:id/delete" do
        @tweet = Tweet.find(params[:id])
        if logged_in? && current_user==@tweet.user.id
            @tweet.delete
            redirect '/tweets'
        else
            redirect '/login'
        end
    end

    get "/tweets/:id/edit" do
        if logged_in? && current_user==Tweet.find(params[:id]).user.id
            @tweet = Tweet.find(params[:id])
            erb :"tweets/edit_tweet"
        else
            redirect '/login'
        end
    end
    post "/tweets/:id/edit" do
        @tweet = Tweet.find(params[:id])
        @tweet.update(params[:tweet])
    end
    
    get "/tweets/new" do
        if logged_in?
            erb :"tweets/create_tweet"
        else
            redirect '/login'
        end
    end

    get "/tweets/:id" do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :"tweets/show_tweet"
        else
            redirect '/login'
        end
    end


    get "/tweets" do 
        if logged_in?
            @user = User.find(current_user)
            erb :"tweets/tweets"
        else
            redirect '/login'
        end
    end
    post "/tweets" do

        if logged_in?                     
            @user = User.find(current_user) 
            if params[:tweet][:content] == ''
                redirect "/tweets/new"
            else
                @tweet = @user.tweets.create(params[:tweet])
            end
            redirect "/users/#{@user.slug}"
        else
            redirect "/login"
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :"users/show"
    end

end