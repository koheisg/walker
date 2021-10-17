require 'mini_magick'

class OgpsController < ApplicationController
  def show
    if params[:text]
      image = genarate(params[:text])
      send_data image, type: 'image/png', disposition: 'inline'
    end
  end

  private
    def genarate(text)
      image = MiniMagick::Image.open('./app/assets/images/ogp_background.png')
      image.combine_options do |config|
        config.font './app/assets/fonts/Noto_Sans_JP/NotoSansJP-Regular.otf'
        config.fill 'white'
        config.gravity 'center'
        config.pointsize 65
        config.draw "text 0,0 '#{text.scan(/.{1,24}/)[0...8].join("\n")}'"
      end
      image.tempfile.open.read
    end
end
