require 'singleton'
require 'treekd'

class PixelTree
  include Singleton
  attr_accessor :tree

  def self._load(str)
    @points = []
    Pixel.all.each { |p|
      @points << Collections::PointKD.new([p.r,p.g,p.b],p)
    }
    
    instance.tree = Collections::TreeKD.new(@points,3)
    
    instance
  end
end