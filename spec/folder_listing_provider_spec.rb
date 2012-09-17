require 'spec_helper'
require File.expand_path('../../lib/folder_listing_provider', __FILE__)

describe MoviesLibrary::FolderListingProvider do
	it "should retrieve folders list from required folder" do
		folder_listing_provider = MoviesLibrary::FolderListingProvider.new(get_absolute_path_to_resource_folder('test_folder_1'))

		folders = folder_listing_provider.get_folders

		folders.should_not be_nil
		folders.count.should == 2
		folders.any? {|f| f.name == 'dir_1' }.should be_true
		folders.any? {|f| f.name == 'dir_2' }.should be_true
	end

	private
		def get_absolute_path_to_resource_folder(folder_name)
			File.expand_path("../resources/#{folder_name}", __FILE__)
		end
end