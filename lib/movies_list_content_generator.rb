require File.expand_path('../../_templates/index', __FILE__)

module MoviesLibrary
	class MoviesListContentGenerator
		def initialize(movie_listing_provider)
			@movie_listing_provider = movie_listing_provider
		end

		def generate_movies_list_page
			movie_folders = @movie_listing_provider.get_folders
			
			index = Templates::Index.new
			index.movies = movie_folders.collect {|mf| mf.movie }

			File.open(File.expand_path('../../_movies/index.html', __FILE__), 'w') do |f|
				f.puts index.render
			end
		end
	end
end