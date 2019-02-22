module Slugifiable
  def slug 
    @slug = username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    @slug
  end
  
end