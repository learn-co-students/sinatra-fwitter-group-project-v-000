class UsersController < ApplicationController

  post 'users/new' do
    raise params.inspect
  end

end
