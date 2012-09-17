require File.expand_path('../models/folder', __FILE__)

module MoviesLibrary
	class FolderListingProvider
		def initialize(folder_path)
			@folder_path = folder_path
		end

		def get_folders
			folder_path = Dir.entries(@folder_path).select do |entry|
				File.directory? File.join(@folder_path, entry) and !(entry =='.' || entry == '..')
			end

			folder_path.collect do |fp|
				MoviesLibrary::Models::Folder.new(File.join(@folder_path, fp))
			end
		end
	end
end