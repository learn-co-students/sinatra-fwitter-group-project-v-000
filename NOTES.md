** Helper Methods **

class Helpers

  #finds current user, based on session user_id value
  def self.current_user(session)
    User.find(session[:user_id])
  end

  #returns true if session has user_id
  def self.logged_in?(session)
    !!session[:user_id]
  end

  #Note: Only use "self" if defined in separate class

end

APPLICATION: 
  - use in Controller Route if/else to test for #is_logged_in? before sending to private page; otherwise send to error/login page
  - use in Views to test for #is_logged_in? before showing private info - if logged in, use #current_user to get user; otherwise send to error/login page;


** Signup Form **

  post "/signup" do
    if params[:username] == "" || params[:password] == ""
      redirect '/failure'
    else
      @user = User.new(username: params[:username], password: [:password])
      @user.save
      redirect '/login'
    end
  end

APPLICATION:
  - use in Controller Route if/else so that User class can test for presence of name, password, etc. - then make new user; else send to signup/failure page


** Secure Login Passwords **

- gem "bcrypt"
- migration with t.string :password_digest
- class User < ActiveRecord::Base
    has_secure_password
  end

  post "/login" do
    if params[:username] == "" || params[:password] == ""
      redirect #somewhere
    else
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect #somewhere
      end
    end
  end

APPLICATION:
  - use in Controller Route if/else to test for entry of username, password, etc - then send to route that renders private view; else send to login/failure

      #Note: redirect Route may use helper (#logged_in) prior to rendering view; then view may use helper (#current_user) to get user info

** Slugs and Find by Slug
  def slug
    self.username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    self.all.find {|user| user.slug == slug}
  end

  get '/artists/:slug' do
    @artist = Artist.find_by_slug(params[:slug])
    erb :'artists/show'
  end

APPLICATION:
  - use in body of Controller Route, with params[:slug] (e.g., show page users/:slug)