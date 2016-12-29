class UsersController < Sinatra::Base

  include Helper

  configure do
    set :views, "app/views/users"
    enable :sessions
    set :session_secret, "what a wonderful secret this is"
    use Rack::Flash
  end

  set(:logged_in) { |bool| condition { logged_in? == bool } }

  get "/signup" do
    redirect to("/tweets") if logged_in?
    erb :signup
  end

  post "/signup" do
    # # Apparently none of this is wanted by the spec. Shame.
    # if User.find_by(email: params[:email])
    #   flash[:message] = "You already have an account!"
    #   redirect to("/signup")
    # elsif User.find_by(username: params[:username])
    #   flash[:message] = "The username '#{params[:username]}' is taken. Please try another."
    #   redirect to("/signup")
    # elsif params[:username].empty? || params[:email].empty? || params[:password].empty?
    #   flash[:message] = "No loopholes! Please fill out all the items!"
    #   redirect to("/signup")
    # end
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      flash[:message] = "No loopholes! Please fill out all the items!"
      redirect to("/signup")
    end
    user = User.create(
      username: params[:username],
      email: params[:email],
      password: params[:password]
    )
    session[:id] = user.id
    flash[:message] = "Login successful!"
    redirect to("/tweets")
  end

  get "/login" do
    redirect to("/tweets") if logged_in?
    erb :login
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect to("/tweets")
    else
      flash[:message] = "Incorrect username and/or password. Please try again!"
      redirect to("/login")
    end
  end

  get "/logout" do
    session.clear
    redirect to("/login")
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :show
  end

  get /\A\/.+/, logged_in: false do
    redirect to("/login")
  end

end
