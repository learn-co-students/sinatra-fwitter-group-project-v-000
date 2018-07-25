class TweetsController < ApplicationController

get '/tweets' do
  @user = User.find_by(params[:id])
  @users = User.all
  erb :tweets
end

end
