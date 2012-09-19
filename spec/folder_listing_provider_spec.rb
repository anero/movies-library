require 'spec_helper'
require File.expand_path('../../lib/folder_listing_provider', __FILE__)

describe MoviesLibrary::FolderListingProvider do
	before(:all) do
		Dir.mkdir(get_absolute_path_to_temp_resource_folder(''))
		Dir.mkdir(get_absolute_path_to_temp_resource_folder('dir_1'))
		Dir.mkdir(get_absolute_path_to_temp_resource_folder('dir_2'))
	end
	after(:all) do
		Dir.delete(get_absolute_path_to_temp_resource_folder('dir_1'))
		Dir.delete(get_absolute_path_to_temp_resource_folder('dir_2'))
		Dir.delete(get_absolute_path_to_temp_resource_folder(''))
	end

	it "should retrieve folders list from required folder" do
		folder_listing_provider = MoviesLibrary::FolderListingProvider.new(get_absolute_path_to_temp_resource_folder)

		folders = folder_listing_provider.get_folders

		folders.should_not be_nil
		folders.count.should == 2
		folders.any? {|f| f.name == 'dir_1' }.should be_true
		folders.any? {|f| f.name == 'dir_2' }.should be_true
	end

	private
		def get_absolute_path_to_temp_resource_folder(folder_name='')
			File.expand_path("../resources/#{folder_name}", __FILE__)
		end
end