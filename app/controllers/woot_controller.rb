# eoncoding: utf-8
class WootController < ApplicationController
  def show
    expires_now

    tempfile = "#{Rails.root}/humbleshot.png"
    vail = "#{Rails.root}/dick-in-a-box.png"

    if File.exist?(vail)
      if !File.exist?(tempfile) || Woot.regenerate?
        Woot.delay.fetch!(tempfile, vail)
        Woot.regenerated!
      end
    else
      Woot.fetch!(tempfile, vail)
    end

    send_file vail, :type => 'image/png', :disposition => 'inline'
  end
end
