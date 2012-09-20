require File.expand_path('../models/folder', __FILE__)

module MoviesLibrary
	class FolderListingProvider
		def initialize(folder_path)
			@folder_path = folder_path
		end

		def get_folders(options={})
			folder_path = Dir.entries(@folder_path).select do |entry|
				File.directory? File.join(@folder_path, entry) and !(entry =='.' || entry == '..')
			end

			folders = folder_path.collect do |fp|
				MoviesLibrary::Models::Folder.new(File.join(@folder_path, fp))
			end

			if (options[:order_by])
				folders = folders.sort_by {|f| f.send(options[:order_by]) unless !f.respond_to?(options[:order_by])}
			end

			folders
		end
	end
end