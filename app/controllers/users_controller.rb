class UsersController < ApplicationController

  get '/users/:slug' do
    @user = Helpers.current_user(session)
    erb :'/users/index'
  end
end
