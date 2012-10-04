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
    def create_and_populate_folder(folder_name, files)
      Dir.mkdir(get_absolute_path_to_temp_resource_folder(''))
      Dir.mkdir(get_absolute_path_to_temp_resource_folder(folder_name))

      files.each do |file|
        if file.respond_to?(:each)
          file.each do |k,v|
            f = File.open(File.join(get_absolute_path_to_temp_resource_folder(folder_name), k), 'w+')
            f.write(v)
            f.close
          end
        else
          File.open(File.join(get_absolute_path_to_temp_resource_folder(folder_name), file), 'w+')
        end
      end
    end

    def cleanup_folder(folder_name)
      folder_path = get_absolute_path_to_temp_resource_folder(folder_name)
      Dir.entries(folder_path).select do |entry|
        if !File.directory?(File.join(folder_path, entry)) and !(entry =='.' || entry == '..')
          File.delete(File.join(folder_path, entry))
        end
      end

      Dir.delete(folder_path)
      Dir.delete(get_absolute_path_to_temp_resource_folder(''))
    end

		def get_absolute_path_to_temp_resource_folder(folder_name='')
			File.expand_path("../resources/#{folder_name}", __FILE__)
		end
	end
end