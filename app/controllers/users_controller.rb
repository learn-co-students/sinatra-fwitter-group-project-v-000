class UsersController < ApplicationController

  get '/users/:slug' do
    @user = Users.find_by_slug(params[:slug])
    redirect to '/tweets'
  end


end
