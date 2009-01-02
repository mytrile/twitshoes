Shoes.setup do
  gem 'twitter'
end
#Just testing git
require 'twitter'

class TwitShoes2 < Shoes
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
            para "#{status}", :size => 9, :font => "Arial", :stroke => '#dddddd'
          end
        end
      end
    }
  end

  def login
    @username = ask "Please, enter your username:"
    @password = ask "Please, enter your password:", :secret => true
    user = Twitter::Base.new(@username, @password, { :encoding => 'utf-8'}).user(@username)
    @name = user.name
  end

  def timeline
    @img, @status = [], []
    Twitter::Base.new(@username, @password).timeline.each do |s|
      @img   << s.user.profile_image_url
      @status << s.text
    end
    [@img, @status]
  end

end
Shoes.app :width => 260, :height => 400, :resizable => true, :title => "TwitShoes"
