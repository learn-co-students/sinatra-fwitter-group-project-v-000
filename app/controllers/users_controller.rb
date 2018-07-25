class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_id(params[:id])
    erb :show
  end

end
