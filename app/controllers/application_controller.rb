require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

get '/' do

  erb :index

end

get '/signup' do
if session[:user_id]
   redirect '/tweets'
 end

  erb :'users/create_user'

end

get '/login' do
  if session[:user_id]
     redirect '/tweets'

   end
  erb :'users/login'
end

post '/login' do
  if @current_user = User.find_by(params)
  session[:user_id]= @current_user.id
  redirect '/tweets'
else
  redirect '/login'


end
end

post '/signup' do

  if params[:username].empty?
     redirect '/signup'

    elsif params[:email].empty?
      redirect '/signup'

    elsif params[:password].empty?
      redirect '/signup'

    else @current_user = User.create(params)
      session[:user_id]= @current_user.id
      redirect '/tweets'

    end
end

get '/logout' do
  if is_logged_in?
  session.clear
  redirect '/login'
else
  redirect '/'
end
end

helpers do
  def current_user
    if session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end
end

  def is_logged_in?
    !!current_user
  end
end

end
