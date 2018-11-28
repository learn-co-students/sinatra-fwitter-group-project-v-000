class Tweet < ActiveRecord::Base
  belongs_to :user

  def self.valid_params?(params)
     return !params[:content].empty?
   end

end
