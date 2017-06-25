class UserController < ApplicationController

	get '/users/new' do
		erb :'users/create_user'
	end 

	post 'users/new' do

	end 

	get 'user/:slug' do

	end 

end 