require 'treekd'

class PixelController < ApplicationController
  def index
  end
  
  def upload
    # TODO : this should be moved to a singleton, indeed !
    @points = []
    Pixel.limit(1000).each { |p|
      @points << Collections::PointKD.new([p.r,p.g,p.b],p)
    }
    
    @tree = Collections::TreeKD.new(@points,3)
    
    uploaded_io = params[:file]
    
    #img = Magick::ImageList.new("#{Rails.public_path}/tiksy.JPG")
    img = Magick::ImageList.new
    img.from_blob(uploaded_io.read)
    
    # formula is -> w(70)*tile_width(70) = 4900
    w = 70
    # calculate the ralative h depending the ratio
    h = (w*img.rows)/img.columns

    # get the number of tiles for width and height
    wi = img.columns / w
    hi = img.rows / h
    
    
    # final image (result)
    b = Magick::ImageList.new
    
    # create a new page for the mosaic generation
    page = Magick::Rectangle.new(0,0,0,0)
    
    w.times { |x|
      h.times{ |y|
        #crop the input image 
        crop = img.crop(x*wi,y*hi,wi,hi)
        
        # get the avarage RGB in it
        avg = average(crop)
        
        # get the nearst node from the avg rgb
        nimg = @tree.nearest(Collections::PointKD.new(avg)).value.data.image
        
        # scale it to half size
        b << nimg.scale(0.5) # thumbnail = 140, so 140*0.5 = 70
        # create a new page(rectangle) for the mosaic generation
        page.x = x * b.rows
        page.y = y * b.columns
        b.page = page
        
      }
    }
    # generate the proper mosaic
    mosaic = b.mosaic
    # save it in a tmp folder
    mos_filename = Digest::MD5.hexdigest(mosaic.to_blob)
    f = File.new("#{Rails.root.join('tmp')}/#{mos_filename}.jpg","w+")
    mosaic.write(f)
    
    # create the db entry to hold the image
    @user_image = UserImage.new
    @user_image.image = f
    @user_image.save!
    
    redirect_to user_images_path(@user_image.id)
    
  end
  
  protected
  
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
