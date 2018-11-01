class UsersController < ApplicationController
  get "/users/:id" do
    @user = User.find(params[:id])

    if Helpers.is_logged_in?(session)
      erb :"users/show"
    else
      redirect "/login"
    end
  end
end
