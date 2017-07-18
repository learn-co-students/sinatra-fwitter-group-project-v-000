class UsersController < ApplicationController

  get '/users/:slug' do
    erb :'users/show_user_tweets'
  end

end
