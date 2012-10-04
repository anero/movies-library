module MoviesLibrary
	module Models
		class Movie
			attr_accessor :title, :synopsis, :download_date, :has_subtitles, :download_complete

			def initialize(*attributes)
		    if attributes.length == 1 && attributes.first.kind_of?(Hash)
		      attributes.first.each { |k,v| send("#{k}=",v) }
		    end
		  end

		  def has_synopsis
		  	!synopsis.nil? && !synopsis.empty?
		  end
		end
	end
end