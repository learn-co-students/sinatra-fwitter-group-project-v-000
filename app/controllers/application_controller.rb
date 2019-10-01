require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
		set :session_secret, "password_security"
  end
  
  get "/" do 
  erb :index
  end
  
   delete "/tweets/:id/delete" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
        if @tweet && (@tweet.user == current_user)
          @tweet.delete
          redirect "/tweets"
        else 
          redirect "/tweets/#{@tweet.id}"
        end
    else
      redirect '/login'
    end
  end
  
  patch "/tweets/:id" do 
    if logged_in? 
      if params[:content] == ""
        redirect "/tweets/#{params[:id]}/edit"
      else
        
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && (@tweet.user_id == current_user.id)
           @tweet.update(content: params[:content])
         
           redirect "/tweets/#{@tweet.id}"
        else 
          redirect "/tweets"
        end 
      end
    else
       redirect "users/login"
    end
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
