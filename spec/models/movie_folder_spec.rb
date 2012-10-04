require 'spec_helper'
require File.expand_path('../../../lib/models/movie_folder', __FILE__)

describe MoviesLibrary::Models::MovieFolder do
	include MoviesLibrary::MovieFolderHelper

	it "should create a movie from valid folder" do
		# TODO: use stub to remove dependency on folder at file system
		create_and_populate_folder('valid_movie_folder', ['my_movie.avi', {'sinopsis.txt' => 'This is my synopsis'}, 'subtitle.srt'])

		begin			
			movie_folder = MoviesLibrary::Models::MovieFolder.new(get_absolute_path_to_temp_resource_folder('valid_movie_folder'))

			movie = movie_folder.movie

			movie.title.should eq 'valid_movie_folder'
			movie.download_date.should eq Date.today			
			movie.has_synopsis.should be_true
			movie.has_subtitles.should be_true
			movie.download_complete.should be_true
		ensure
			cleanup_folder('valid_movie_folder')
		end
	end

	it "should create an incomplete movie from a folder without a movie file" do
		# TODO: use stub to remove dependency on folder at file system
		create_and_populate_folder('valid_movie_folder', [{'sinopsis.txt' => 'This is my synopsis'}, 'subtitle.srt'])

		begin
			movie_folder = MoviesLibrary::Models::MovieFolder.new(get_absolute_path_to_temp_resource_folder('valid_movie_folder'))
			
			movie = movie_folder.movie

			movie.title.should eq 'valid_movie_folder'
			movie.download_date.should eq Date.today			
			movie.has_synopsis.should be_true
			movie.has_subtitles.should be_true
			movie.download_complete.should be_false
		ensure
			cleanup_folder('valid_movie_folder')
		end
	end

	it "should create an incomplete movie if missing synopsis file" do
		# TODO: use stub to remove dependency on folder at file system
		create_and_populate_folder('valid_movie_folder', ['my_movie.avi', 'subtitle.srt'])

		begin
			movie_folder = MoviesLibrary::Models::MovieFolder.new(get_absolute_path_to_temp_resource_folder('valid_movie_folder'))
			
			movie = movie_folder.movie

			movie.title.should eq 'valid_movie_folder'
			movie.download_date.should eq Date.today
			movie.has_synopsis.should be_false
			movie.has_subtitles.should be_true
			movie.download_complete.should be_true
		ensure
			cleanup_folder('valid_movie_folder')
		end
	end
end