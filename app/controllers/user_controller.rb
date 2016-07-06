class UserController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])    
    erb :'users/all_tweets'
  end

end