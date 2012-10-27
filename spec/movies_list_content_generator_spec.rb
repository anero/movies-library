require 'spec_helper'
require File.expand_path('../../lib/models/movie', __FILE__)
require File.expand_path('../../lib/movies_list_content_generator', __FILE__)
require File.expand_path('../../_templates/index', __FILE__)

describe MoviesLibrary::MoviesListContentGenerator do
	it "should generate movies list from movie folder listing provider" do
		movie_folder_listing_provider = double
		movie1 = double
		movie1.should_receive(:movie).and_return(MoviesLibrary::Models::Movie.new(
				:title => 'My Movie #1', 
				:synopsis => 'Synopsis for movie #1', 
				:download_date => Date.today, 
				:has_subtitles => true, 
				:download_complete => true))
		movie2 = double
		movie2.should_receive(:movie).and_return(MoviesLibrary::Models::Movie.new(
				:title => 'My Movie #2', 
				:synopsis => 'Synopsis for movie #2', 
				:download_date => Date.today.prev_day, 
				:has_subtitles => false, 
				:download_complete => true))
		movie_folders = [ movie1, movie2 ]
		movie_folder_listing_provider.should_receive(:get_folders).and_return(movie_folders)
		index = double
		index.should_receive(:movies=)
		Templates::Index.stub(:new).and_return(index)
		File.should_receive(:open)

		movies_list_content_generator = MoviesLibrary::MoviesListContentGenerator.new(movie_folder_listing_provider)
		
		movies_list_content_generator.generate_movies_list_page
	end
end