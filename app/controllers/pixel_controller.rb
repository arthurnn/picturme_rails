require 'treekd'

class PixelController < ApplicationController
  def index
  end
  
  def upload
    @points = []
    Pixel.all.each { |p|
      @points << Collections::PointKD.new([p.r,p.g,p.b],Magick::ImageList.new("#{Rails.public_path}/#{p.image1}"))
    }
    
    @tree = Collections::TreeKD.new(@points,3)
    
    uploaded_io = params[:file]
    
    #img = Magick::ImageList.new("#{Rails.public_path}/tiksy.JPG")
    img = Magick::ImageList.new
    img.from_blob(uploaded_io.read)
    
    # w(70)*tile_width(70) = 4900
    w = 70
    h = (w*img.rows)/img.columns

    wi = img.columns / w
    hi = img.rows / h
    
    page = Magick::Rectangle.new(0,0,0,0)
    b = Magick::ImageList.new
    
    w.times { |x|
      h.times{ |y|
        crop = img.crop(x*wi,y*hi,wi,hi)
        
        avg = average(crop)
        nimg = @tree.nearest(Collections::PointKD.new(avg)).value.data
        
        b << nimg.scale(0.5) # thumbnail = 140, so 140*0.5 = 70
        page.x = x * b.rows
        page.y = y * b.columns
        b.page = page
        
      }
    }
    
    mosaic = b.mosaic
    mos_filename = Digest::MD5.hexdigest(mosaic.to_blob)
    f = File.new("#{Rails.root.join('tmp')}/#{mos_filename}.jpg","w+")
    mosaic.write(f)
    
    @user_image = UserImage.new
    @user_image.image = f
    @user_image.save!
    
    redirect_to user_images_path(@user_image.id)
    
  end
  
 def average(img)
    total = 0
    avg   = { :r => 0.0, :g => 0.0, :b => 0.0 }
    img.quantize.color_histogram.each { |c, n|
      avg[:r] += n * c.red
      avg[:g] += n * c.green
      avg[:b] += n * c.blue
      total   += n
    }
    [:r, :g, :b].each { |comp| avg[comp] /= total }
    [:r, :g, :b].each { |comp| avg[comp] = (avg[comp] / Magick::QuantumRange * 255).to_i }
    [avg[:r],avg[:g],avg[:b]]
  end

end
