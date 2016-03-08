class UserController < ApplicationController
	
	get '/users/:slug' do
		@user = User.find_by(:username => params[:slug])
		erb :'/users/show'
	end

end