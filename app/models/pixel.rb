class Pixel < ActiveRecord::Base
  mount_uploader :image1, TileUploader
  
  def image
    @image ||= Magick::ImageList.new(image1)
  end
  
end