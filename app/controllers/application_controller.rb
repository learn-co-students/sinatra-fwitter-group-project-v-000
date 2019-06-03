require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions unless test?
    set :session_secret, "$3kR*Tk3y5"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    if Helpers.logged_in?(session)
      @user = Helpers.current_user(session)
    end

    erb :index
  end

end
