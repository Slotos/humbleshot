class Woot
  include Magick

  @@time = 1.hour.ago
  def self.regenerate?
    @@time < 1.minute.ago ? true : false
  end

  def self.regenerated!
    @@time = Time.now
  end

  def self.fetch!(that, here)
    `phantomjs #{Rails.root}/rasterize.js http://www.humblebundle.com/ #{that}`

    image = ImageList.new(that)
    image.crop!(175,1465,770,240, true)

    text = Draw.new
    text.annotate(image, 0,0,5,0, "Screenshot generated at #{Time.now.strftime("%H:%M:%S")} GMT") {
      self.fill = 'black'
      self.stroke = 'transparent'
      self.pointsize = 12
      self.font_weight = NormalWeight
      self.gravity = SouthEastGravity
    }

    result = image.to_blob
    Rails.cache.write(here, result)
    regenerated!

    result
  end
end
