require './config/environment'

class ApplicationController < Sinatra::Base
	require_all 'app'
	require_all 'app/helpers'
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
		enable :sessions
		set :session_secret, "fwitter"
  end
  get '/' do
		erb :index
	end
	get '/signup' do
		if Helpers.is_logged_in?(session)
			redirect to '/tweets'
		else
			erb :'users/create_user', :layout => false
		end
  end
  post "/signup" do
    @user = User.create(:username => params[:username], :password => params[:password], :email => params[:email])
		if @user.save
	    session[:user_id] = @user.id
			redirect to '/tweets'
		else
			redirect to '/signup'
		end
  end
  get '/logout' do
		if !Helpers.is_logged_in?(session)
			redirect to '/login'
		else
	    session.clear
	    redirect to '/login'
		end
  end

  get '/login' do
		if Helpers.is_logged_in?(session)
			redirect to '/tweets'
		else
    	erb :'users/login', :layout => false
		end
  end
  post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to '/tweets'
      else
        @fail = true
        erb :'/users/login', :layout => false
      end
  end
end
