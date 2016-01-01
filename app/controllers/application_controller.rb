class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    # enable :sessions
    # set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    if blank_form?
      erb :signup, locals: {invalid_signup: "Please fill in each field."}
    elsif taken_username?
      erb :signup, locals: {taken_username: "Username is already taken."}
    elsif taken_email?
      erb :signup, locals: {taken_email: "Email address is already taken."}
    else
      user = User.new(params[:signup])
      user.before_save
      user.save
      session[:user_id] = user.id
      redirect '/tweets'
    end
  end

  get '/tweets' do
    erb :tweets
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def is_logged_in?
      !!session[:user_id]
    end

    def blank_form?
      params[:signup].values.any?{|x| x == ""}
    end

    def taken_username?
      !User.find_by(username: params[:signup][:username].downcase).nil?
    end

    def taken_email?
      !User.find_by(email: params[:signup][:email].downcase).nil?
    end
  end
end
