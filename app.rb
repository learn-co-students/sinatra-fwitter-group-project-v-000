require_relative 'config/environment'

class App < Sinatra::Base
  
  get '/' do
    erb :layout
  end
  
  get '/tweets/new' do
    
  end
  
  post '/tweets' do
    
  end
  
  get '/tweets/:id' do
    
  end
  
  get '/tweets/:id/edit' do
    
  end
  
  post '/tweets/:id' do
    
  end
  
  post 'tweets/:id/delete' do
    
  end
  
  get '/signup' do
    
  end
  
  post '/signup' do
    
  end
  
  get '/login' do
    
  end
  
  get '/logout' do
    
  end
  
end
