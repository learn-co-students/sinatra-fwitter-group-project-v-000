class UsersController < ApplicationController

post '/users' do
  @user = User.create(username: params[:username], email: params[:email], password: params[:password_digest])
  @user.save

  redirect to :"/user/#{@user.id}"
end

end
