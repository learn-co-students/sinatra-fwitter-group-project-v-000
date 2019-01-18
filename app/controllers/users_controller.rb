class UsersController < ApplicationController
    get '/' do
        erb :'/index'
      end
    
      #loads the signup page
      get '/signup' do
        erb :'/users/create_user'
      end
    
      post '/signup' do
        erb :'/tweets'
      end

end
