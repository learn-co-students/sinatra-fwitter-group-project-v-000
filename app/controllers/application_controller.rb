require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "93160167"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    # def slug
    #   self.slugify
    # end
    #
    # def find_by_slug(slug)
    #    self.all.find{ |instance| instance.slug == slug }
    # end

  end

end
