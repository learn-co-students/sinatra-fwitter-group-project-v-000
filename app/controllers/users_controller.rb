

class UserController < Sinatra::Base

    get '/signup' do
#binding.pry
         erb :"users/create_user"

    end


end


# =>        rspec spec/controllers/application_controller_spec.rb
