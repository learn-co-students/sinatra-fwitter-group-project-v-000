class UsersController < ApplicationController
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get "/users/:slug" do
    # binding.pry
    # if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :"users/show"
    # else
    #   redirect :"/login"
    # end
  end

end
