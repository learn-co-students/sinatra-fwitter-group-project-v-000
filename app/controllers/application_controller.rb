require './config/environment'
#====================================================================== 
class ApplicationController < Sinatra::Base
#=============================configure================================ 
  configure do 
    enable :sessions
    set :session_secret, "fwitter_secret"
    # set :public_folder, 'public'
    set :public_folder, 'static'
    set :views, Proc.new { File.join(root, "../views/") }
  end
#===============================index================================== 
  get '/' do 
    redirect '/tweets' if logged_in?
    
    erb :"index"
  end
#==============================helpers================================= 
  def logged_in? 
    !!current_user
  end
    
  def current_user 
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def set_session(id)
    session[:user_id] = id
  end
  
  def authentic?(user, password)
    user && user.authenticate(password)
  end
  
  def empty?(arg)
    arg.values.any?{|v|v.empty?}
  end
  
  def tweet(id)
    Tweet.find(id)
  end
#====================================================================== 
end














