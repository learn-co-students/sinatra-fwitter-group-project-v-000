class UsersController < ApplicationController

  get '/users/:slug' do
    @tweets = Tweet.all
    erb :'/users/show'
  end

end
