class UsersController < ApplicationController

	get '/users/:slug' do
    @user = User.find(params[:slug])
    erb :'/tweets/show'
  end

end