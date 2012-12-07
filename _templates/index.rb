# encoding: UTF-8
require 'mustache'

module Templates
	class Index < Mustache
		attr_reader :movies
		
		self.template_file = File.expand_path('../index.html.mustache', __FILE__)

		def movies=(movies)
			@movies = []

			movies.each do |m|
				movie_view = OpenStruct.new

				movie_view.title = m.title
				movie_view.synopsis = m.synopsis.gsub(/\n/m, '<br/>')
				movie_view.download_date = m.download_date
				movie_view.download_complete = m.download_complete ? 'Sí' : 'No'
				movie_view.has_subtitles = m.has_subtitles ? 'Sí' : 'No'

				@movies << movie_view
			end
		end
	end
end