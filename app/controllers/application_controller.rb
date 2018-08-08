require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
		# binding.pry    
		if logged_in?
			redirect to '/'
		else
			erb :signup
		end
  end

	post '/signup' do
		if params[:username].empty? || params[:email].empty? || params[:password].empty?
			redirect to '/signup'
		else
			@user = User.create(params)
			# binding.pry
			session[:user_id] = @user.id
			redirect to '/tweets'
		end
	end

  get "/logout" do
    session.clear
    redirect "/"
  end

	helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
