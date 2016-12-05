class UsersController < ApplicationController
	get 'signup' do
		erb :"users/new"
	end

	post '/users' do
		@user = User.new
	end
end