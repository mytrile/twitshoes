Shoes.setup do
  gem 'twitter'
end
require 'twitter'

class TwitShoes < Shoes
  url '/', :index

  def index
    background "#0f0f0f"
    user = login
    t = timeline

    t[0].zip(t[1]).each { |img, status|
      flow :margin => 2 do
        background "#333333".."#1d1d1d", :curve => 6
        border "#373737",:curve => 6 
        flow :margin => 5 do
          stack :width => "20%" do
            image "#{img}"
          end
          stack :width => "80%" do
            para "#{status}", :size => 9, :font => "Verdana", :stroke => '#dddddd'
          end
        end
      end
    }
  end

  def login
    @username = ask "Please, enter your username:"
    @password = ask "Please, enter your password:", :secret => true
    user = Twitter::Base.new(@username, @password).user(@username)
    @name = user.name
  end

  def timeline
    @img, @status = [], []
    Twitter::Base.new(@username, @password).timeline.each do |s|
      @img   << s.user.profile_image_url
      @status << to_utf(s.text)
    end
    [@img, @status]
  end
  
  def to_utf string
    string.gsub(/&#(\d+);/){[$1.to_i].pack("U")}
  end

end
Shoes.app :width => 260, :height => 400, :resizable => true, :title => "TwitShoes"
