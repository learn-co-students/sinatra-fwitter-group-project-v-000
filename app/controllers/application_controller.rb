require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions                    #sets sessions

  end

    get '/' do
#binding.pry      
         erb :index

    end


end


# =>        rspec spec/controllers/application_controller_spec.rb
