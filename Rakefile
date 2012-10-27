require 'rspec/core'
require 'rspec/core/rake_task'
require File.expand_path('../lib/movie_folder_listing_provider', __FILE__)
require File.expand_path('../lib/movies_list_content_generator', __FILE__)

task :default => :spec

desc "Run all specs in spec directory (excluding plugin specs)"
RSpec::Core::RakeTask.new(:spec)

desc "Scans the folder passed as argument and prints info on the Movies found"
task :print_movies do
	if !ENV['folder_path']
		raise ArgumentError.new "An absolute path to a folder must be provided in the 'folder_path' environment variable."
	end

	folder_listing_provider = MoviesLibrary::MovieFolderListingProvider.new(ENV['folder_path'])
	movie_folders = folder_listing_provider.get_folders
	movie_folders.each {|mf|
		movie = mf.movie

		puts "Movie: #{movie.title}\n"
		puts "\tDownload complete: #{movie.download_complete}\n"
		puts "\tDownload date: #{movie.download_date}\n"
		puts "Synopsis: #{movie.synopsis}\n\n"
	}
end

desc "Scans the folder passed as argument and generates Movie content pages"
task :create_movie_pages do
	folder_listing_provider = MoviesLibrary::MovieFolderListingProvider.new(ENV['folder_path'])
	movies_list_generator = MoviesLibrary::MoviesListContentGenerator.new(folder_listing_provider)

	movies_list_generator.generate_movies_list_page
end