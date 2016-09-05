class TweetsController < Sinatra::Base

  get '/tweets/new' do
    erb :'tweets/new'
  end

  post '/tweets' do 
    
  end 

end