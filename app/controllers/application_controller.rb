# require './config/environment'

class ApplicationController < Controller

	get '/' do 
		erb :index
	end

end