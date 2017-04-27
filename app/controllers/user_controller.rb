class UserController < ApplicationController
	 get '/tweets' do

  end

  get '/tweets/:id/edit' do
  end

  post '/tweets/:id' do
  	#update to tweets/id
  end

  post '/tweets/:id/delete' do
  	#deletion of tweet 
  end
end