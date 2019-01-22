class UsersController < ApplicationController
    
    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
    end

    get '/' do
      erb :'/index'
    end
    
    #loads the signup page
    get '/signup' do
      if !logged_in?
        erb :'/users/create_user'
      else
        redirect '/tweets'
      end
    end
    
    post '/signup' do
      erb :'/tweets'
    end

end
