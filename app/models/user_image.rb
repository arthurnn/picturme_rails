class UserImage < ActiveRecord::Base
  mount_uploader :image, UserImageUploader
  
  def image_magic
    @image_magic ||= Magick::ImageList.new(image.path)
  end

  def thumb_magic
    @thumb_magic ||= Magick::ImageList.new(image.thumb.path)
  end

  
end
