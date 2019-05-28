class UsersController < ApplicationController
# use Rack::Flash

  get '/users/:slug' do
    @user = User.find_by_slub(params[:slug])
    erb :'/users/show'
  end

end
