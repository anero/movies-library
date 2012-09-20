module MoviesLibrary
	module Models
		class MovieFolder
			attr_reader :absolute_path, :creation_date

			def initialize(absolute_path)
				@absolute_path = absolute_path
				@creation_date = File.ctime absolute_path
			end

			def name
				File.basename(@absolute_path)
			end
		end
	end
end