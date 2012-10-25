module MoviesLibrary
	class MoviesListContentGenerator
		def initialize(movie_listing_provider)
			@movie_listing_provider = movie_listing_provider
		end

		def generate_movies_list_page
			@movie_listing_provider.get_folders
		end
	end
end