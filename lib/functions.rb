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