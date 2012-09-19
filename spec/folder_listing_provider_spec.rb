require 'spec_helper'
require File.expand_path('../../lib/folder_listing_provider', __FILE__)

describe MoviesLibrary::FolderListingProvider do
	before(:all) do
		Dir.mkdir(get_absolute_path_to_temp_resource_folder(''))
		Dir.mkdir(get_absolute_path_to_temp_resource_folder('dir_z'))
		Dir.mkdir(get_absolute_path_to_temp_resource_folder('dir_x'))
		Dir.mkdir(get_absolute_path_to_temp_resource_folder('dir_y'))
	end

	after(:all) do
		Dir.delete(get_absolute_path_to_temp_resource_folder('dir_z'))
		Dir.delete(get_absolute_path_to_temp_resource_folder('dir_x'))
		Dir.delete(get_absolute_path_to_temp_resource_folder('dir_y'))
		Dir.delete(get_absolute_path_to_temp_resource_folder(''))
	end

	it "should retrieve folders list from required folder" do
		folder_listing_provider = MoviesLibrary::FolderListingProvider.new(get_absolute_path_to_temp_resource_folder)

		folders = folder_listing_provider.get_folders

		folders.should_not be_nil
		folders.count.should == 3
		folders.any? {|f| f.name == 'dir_x' }.should be_true
		folders.any? {|f| f.name == 'dir_y' }.should be_true
		folders.any? {|f| f.name == 'dir_z' }.should be_true
	end

	it "should sort folders list by creation date" do
		folder_listing_provider = MoviesLibrary::FolderListingProvider.new(get_absolute_path_to_temp_resource_folder)

		folders = folder_listing_provider.get_folders(:order_by => :creation_date)

		folders[0].name == 'dir_z'
		folders[1].name == 'dir_x'
		folders[1].name == 'dir_y'
	end

	it "should sort folders list by name" do
		folder_listing_provider = MoviesLibrary::FolderListingProvider.new(get_absolute_path_to_temp_resource_folder)

		folders = folder_listing_provider.get_folders(:order_by => :name)

		folders[0].name == 'dir_x'
		folders[1].name == 'dir_y'
		folders[1].name == 'dir_z'
	end

	private
		def get_absolute_path_to_temp_resource_folder(folder_name='')
			File.expand_path("../resources/#{folder_name}", __FILE__)
		end
end