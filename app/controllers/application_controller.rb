require './config/environment'

class ApplicationController < Sinatra::Base
 register Sinatra::ActiveRecordExtension
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "bing bong"
  end

  get '/' do
    erb :index
  end  
  
end