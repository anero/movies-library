

require File.expand_path('../movie', __FILE__)
require 'ruby-debug'

module MoviesLibrary
	module Models
		
		class InvalidMovieFolderError < StandardError
			def initialize(message)
				super(message)
			end
		end

		class MovieFolder
			attr_reader :absolute_path, :creation_date

			MOVIE_FILE_EXTENSIONS = 'avi|mp4|mkv'

			def initialize(absolute_path)
				@absolute_path = absolute_path
				@creation_date = File.ctime(absolute_path)
			end

			def name
				File.basename(@absolute_path)
			end

			def movie
				synopsis = ''
				synopsis_file_path = File.join(@absolute_path, 'sinopsis.txt')
				if (File.exists? synopsis_file_path)
					synopsis = File.open(synopsis_file_path, 'r:WINDOWS-1252').read.encode('UTF-8', :invalid => :replace, :undef => :replace, :replace => '')
				end
				
				subtitle_filename = Dir.entries(@absolute_path).find {|entry| entry =~ /.+?\.(zip|srt)/i }
				if (subtitle_filename)
					subtitles_file_path = File.join(@absolute_path, subtitle_filename)
				end

				MoviesLibrary::Models::Movie.new({
						:title => name, 
						:synopsis => synopsis, 
						:download_date => @creation_date, 
						:has_subtitles => !subtitles_file_path.nil? && !subtitles_file_path.empty?, 
						:download_complete => Dir.entries(@absolute_path).any? {|entry| entry =~ /\.(#{MOVIE_FILE_EXTENSIONS})/i } })
			end
		end
	end
end