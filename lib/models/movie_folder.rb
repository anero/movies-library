require File.expand_path('../movie', __FILE__)

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
				@creation_date = File.ctime(absolute_path).to_date
			end

			def name
				File.basename(@absolute_path)
			end

			def movie
				synopsis = ''
				synopsis_file_path = File.join(@absolute_path, 'sinopsis.txt')
				if (File.exists? synopsis_file_path)
					synopsis = File.open(synopsis_file_path, 'r').read
				end
				
				subtitle_filename = Dir.entries(@absolute_path).first {|entry| entry =~ /.+?\.(zip|srt)/i }
				if (subtitle_filename)
					subtitles_file_path = File.join(@absolute_path, subtitle_filename)
				end

				MoviesLibrary::Models::Movie.new({
						:title => name, 
						:synopsis => synopsis, 
						:download_date => @creation_date, 
						:has_subtitles => defined?(subtitles_file_path), 
						:download_complete => Dir.entries(@absolute_path).any? {|entry| entry =~ /\.(avi|mp4)/i } })
			end
		end
	end
end