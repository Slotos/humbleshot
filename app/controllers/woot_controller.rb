# eoncoding: utf-8
class WootController < ApplicationController
  def show
    expires_now

    tempfile = "#{Rails.root}/humbleshot.png"
    vail = 'box'

    if chart = Rails.cache.read(vail)
      if Woot.regenerate?
        Woot.delay.fetch!(tempfile, vail)
        Woot.regenerated!
      end
    else
      chart = Woot.fetch!(tempfile, vail)
    end

    send_data chart, :type => 'image/png', :disposition => 'inline'
  end
end
