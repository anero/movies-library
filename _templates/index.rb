require 'mustache'

module Templates
	class Index < Mustache
		self.path = File.dirname(__FILE__)

		attr_accessor :movies
	end
end