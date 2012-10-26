require File.expand_path('../../_templates/index', __FILE__)

module MoviesLibrary
	class MoviesListContentGenerator
		def initialize(movie_listing_provider)
			@movie_listing_provider = movie_listing_provider
		end

		def generate_movies_list_page
			movies = @movie_listing_provider.get_folders
			
			index = Templates::Index.new
			index.movies = movies
			index.render

			# TODO: write generated view to _movies folder as index.html
		end
	end
end