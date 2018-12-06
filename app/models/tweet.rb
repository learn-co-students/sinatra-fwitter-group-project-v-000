class Tweet < ActiveRecord::Base
  belongs_to :user

  def formatted_created_at
    self.created_at.strftime("WELKJASLDNASF")
  end

end
