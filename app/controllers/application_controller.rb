class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end

    def invalid_signup?
      if missing_field?
        @error_message = {missing_field: "Please fill in each field."}
      elsif taken_username?
        @error_message = {taken_username: "Username is already taken."}
      elsif taken_email?
        @error_message = {taken_email: "Email address is already taken."}
      end
    end

    def missing_field?
      params[:data].values.any?{|x| x == ""}
    end

    def taken_username?
      User.find_by(username: params[:data][:username].downcase).present?
    end

    def taken_email?
      User.find_by(email: params[:data][:email].downcase).present?
    end

    def content_unchanged?
      Tweet.find(params[:id]).content == params[:data][:content]
    end
  end
end
