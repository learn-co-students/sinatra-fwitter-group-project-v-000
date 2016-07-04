class UsersController < ApplicationController
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  
end