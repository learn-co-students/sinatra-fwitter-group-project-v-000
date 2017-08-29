require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    erb :index
    # HOME PAGE
    # add the Signup link to the home page
    # create a view that will eventually link to both a login page and signup page.
  end

  get "/tweets/new" do
    # CREATE TWEET form should be loaded
    #redirect "/tweets/create_tweet"
    #def test_should_signin_first_before_add_post
    #get "/admin/posts/new"
    #follow_redirect!
    #follow_redirect!()
    #end
  end

  get "/tweets" do
    if logged_in?
      @tweets = Tweet.all
      @posts = []
        @tweets.each do |t|
          @posts << {User.find(t.user_id).username => t.content, user_id: t.user_id, id: t.id}
        end
        @user = User.find(session[:id])
        erb :'tweets/index'
    else
      redirect "/login"
    end
  end

  post "/tweets" do
    # CREATE TWEET form submitted
    @user = Helpers.current_user(session) if Helpers.is_logged_in?(session)
    if @user
      redirect "/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get "/tweets/:id" do
    # SHOW TWEET displays the information for a single tweets
    # create an edit link on the tweet show page.
    # DELETE TWEET The form to delete a tweet should be found on the tweet show page.
    # The delete form doesn't need to have any input fields, just a submit button
    # The form to delete a tweet should be submitted via a POST request to tweets/:id/delete
  end

  get "/tweets/:id/edit" do
    # EDIT TWEET The form to edit a tweet should be loaded

  end

  post "/tweets/:id" do
    # EDIT TWEET The form should be submitted
  end

  get "/signup" do
    # SIGN UP The form to sign up should be loaded
    # display the user signup
    # signup action should also log the user in and add the user_id to the sessions hash.
    if !session[:user_id] # if !!session[:user_id] if !!session[:id] if logged_in? if :logged_in?
      erb :"users/create_user"
    else
      redirect to "/tweets"
    end
  end

  post "/signup" do
    # SIGN UP submitted to process the form submission.
    #processes the form submission should create the user and save it to the database.
    if params[:username] != "" && params[:email] != "" && params[:password] != ""

    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    @user.save
    session[:user_id] = @user.id
      redirect to "/tweets" #redirect "/tweets
      else
      redirect "/signup"
      end
  end

  get "/login" do
    # LOGIN display the form to log in
    if !logged_in?
       erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post "/login" do
    # LOGIN submitted
    @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:id] = @user[:id]
        redirect '/tweets' #redirect "/index"
      else
        erb :'users/login'
      end
  end

  get "/logout" do
    # LOGOUT submitted
    #clear the session hash
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

  get "/users/#{user.slug}" do

  end

  helpers do
    def logged_in?
       !!current_user
       #!!session[:user_id] #:id
      #@current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def current_user
      @current_user ||= User.find(session[:id]) if session[:id]
      #User.find(session[:id ]) #:user_id
      #redirect_to '/login' unless current_user
      end
    end
end
