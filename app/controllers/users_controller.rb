class UsersController < ApplicationController

  use Rack::Flash

  get '/users/:slug' do
    @current_user = User.find_by_slug(params[:slug])
    erb :"users/show"
  end

end
