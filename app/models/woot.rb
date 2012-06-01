class Woot
  @@time = 1.hour.ago
  def self.regenerate?
    @@time < 1.minute.ago ? true : false
  end

  def self.regenerated!
    @@time = Time.now
  end

  def self.fetch!(that, here)
    `phantomjs #{Rails.root}/rasterize.js http://www.humblebundle.com/ #{that}`

    image = Magick::Image.read(that).first
    image.crop!(175,1465,770,230)

    image.write here
    regenerated!
  end
end
