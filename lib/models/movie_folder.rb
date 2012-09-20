module MoviesLibrary
	module Models
		
		class InvalidMovieFolderError < StandardError
			def initialize(message)
				super(message)
			end
		end

		class MovieFolder
			attr_reader :absolute_path, :creation_date

			def initialize(absolute_path)
				@absolute_path = absolute_path
				@creation_date = File.ctime absolute_path
			end

			def name
				File.basename(@absolute_path)
			end

			def movie
				synopsis_file_path = File.join(@absolute_path, 'sinopsis.txt')
			end
		end
	end
end