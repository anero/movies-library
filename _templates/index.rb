require 'mustache'

module Templates
	class Index < Mustache
		self.template_file = File.expand_path('../index.html.mustache', __FILE__)

		attr_accessor :movies
	end
end