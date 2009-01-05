Shoes.setup do
  gem 'twitter'
end

require 'twitter'
require 'lib/functions'

class TwitShoes < Shoes
  url '/', :index
  url '/main', :main
  def index
    background "#333333".."#1d1d1d"
    flow :margin => [45, 15, 90, 20] do
      image('twitter-logo.png')
    end
    stack :margin => [90, 0, 90, 0] do
      @username = edit_line :text => 'Username', :width => 100, :height => 23 
      @password = edit_line :text => 'Password', :width => 100, :height => 23, :secret => true
      
    end 
       
  end
  
  def main
    
    background "#0f0f0f"
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
            para "#{status}", :size => 8, :font => "Verdana", :stroke => '#dddddd'
          end
        end
      end
    }
  end

end

Shoes.app :width => 280, :height => 500, :resizable => true, :title => "TwitShoes"