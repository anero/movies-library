# coding: utf-8

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
end

module MoviesLibrary
	module MovieFolderHelper
		def get_absolute_path_to_temp_resource_folder(folder_name='')
			File.expand_path("../resources/#{folder_name}", __FILE__)
		end
	end
end