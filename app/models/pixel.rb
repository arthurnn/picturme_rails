class Pixel < ActiveRecord::Base
  def self.image(npath)
    @_image ||= Magick::ImageList.new("#{Rails.public_path}/#{npath}")
  end
end