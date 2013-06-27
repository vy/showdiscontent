# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

def gezi_parki_header(target_url, has_days=true)
	s = '<div id="header">'
  	s += '<a href="https://twitter.com/showdiscontent">'
  	s += '<span class="subtitle twitter-account">@showdiscontent</span>'
  	s += '</a><span class="subtitle"> - A record of</span>'
  	s += '<span class="title"> <a href="/archive/gezi-parki/">Taksim Gezi Park</a> </span>'
  	s += '<span class="subtitle">protest meetings.</span>'
  	if has_days
	  	s += '<span class="day-links"> Day '
	  	[
	  		"2013-05-27,28,29/#27",
	  		"2013-05-27,28,29/#28",
	  		"2013-05-27,28,29/#29",
	  		"2013-05-30/",
	  		"2013-05-31/",
	  		"2013-06-01/",
	  		"2013-06-02/",
	  		"2013-06-03/",
	  		"2013-06-04/",
	  		"2013-06-05/",
	  		"2013-06-06/",
	  		"2013-06-07/",
	  		"2013-06-08/",
	  		"2013-06-09/",
	  		"2013-06-10/",
	  		"2013-06-11/",
	  		"2013-06-12/",
	  		"2013-06-13/"
	  	].each_with_index { |url, idx|
	  		base_url = url.sub(/\/.*$/, "/")
	  		active = (base_url == target_url) ? "hi" : "lo"
	  		s += ", " if idx > 0
	  		s += "<a class='#{active}' href='/archive/gezi-parki/#{url}'>#{idx+1}</a>"
	  	}
	  	s += ".</span>"
  	end
  	s += "</div>"
  	s
end

def gezi_parki_title(name, day, date)
	s = '<div class="day-title">'
	s += "<a name='#{name}'></a>" if name
	s += "<div class='hi'>Day #{day}</div>"
    s += "<div class='lo'>#{date}</div>"
    s += "</div>"
    s
end

def gezi_parki_subtitle(title)
	s = '<div class="day-title">'
	s += "<div class='lo'>#{title}</div>"
    s += "</div>"
    s
end

def gezi_parki_content(blocks)
	s = '<div class="row-fluid"><div class="span12">'
	blocks.each do |block|
		classes = ""
		classes += " info" if block[:info]
		classes += " quote" if block[:quote] and not block[:image]
		style = block[:style] ? " style='#{block[:style]}'" : ""
		s += "<div class='story#{classes}'#{style}>"
		if block[:html]
			s += block[:html]
		elsif block[:info]
			block[:info].each { |info| s += "<div>#{info}</div>" }
		elsif block[:image]
			ext = File.extname(block[:image])
			image = File.basename(block[:image], ext) + '~small' + ext
			s += "<a href='img/#{block[:image]}'><img src='img/#{image}'></a>"
			s += "<div class='text'>#{block[:caption]}</div>" if block[:caption]
			if block[:quote]
				s += '<div class="quote" style="margin-top: 30px">'
				s += "<div class='text'>#{block[:quote]}</div>"
				s += "<div class='author'>#{block[:author]}</div>"
				s += "</div>"
			end
		elsif block[:quote]
			s += "<div class='text'>#{block[:quote]}</div>"
			s += "<div class='author'>#{block[:author]}</div>"
		else
			raise ArgumentError, "Invalid block: #{block}"
		end
		s += "</div>"
	end
	s += "</div></div>"
	s
end
