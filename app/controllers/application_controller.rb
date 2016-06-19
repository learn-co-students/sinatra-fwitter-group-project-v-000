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
    erb :'users/create_user'
  end

  get '/login' do 
    erb :'users/login'
  end

  get '/tweets' do 
    erb :'tweets/tweets'
  end

  post '/signup' do     
   
    @user = User.new(params[:user])
    
   if @user.save
    redirect to '/tweets'
   # elsif session[:id] = user.id
   #  redirect '/login'
   else 
    redirect '/signup'
   end
  end

end