require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :"index"
  end

  helpers do

    def current_user

    end

    def logged_in?
      !!sessions[:email]
    end

    def login(email)
      session[:email] = email
    end

end
end 
