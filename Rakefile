require 'rspec/core'
require 'rspec/core/rake_task'
require File.expand_path('../lib/movie_folder_listing_provider', __FILE__)

task :default => :spec

desc "Run all specs in spec directory (excluding plugin specs)"
RSpec::Core::RakeTask.new(:spec)

desc "Scans the folder passed as argument and prints info on the Movies found"
task :scan_folder do
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