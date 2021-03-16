require 'open-uri'
require 'nokogiri'


module MusicServices 
	class Attributes
		class << self

			def execute!
				super_search("Jack Harlow Jack sadza pussy nuggets")
			end

			def super_search title
				spill = title.split(" ")
				search_results = nil
				artist = ""
				tab = spill.count - 1
				# catch :search_results do
				# if search_results.nil?
				for i in 1..tab
					array = spill.each_cons(i).to_a
					pp array[0]
					ref = array.length
					for j in 0..(ref - 1)
						query = array[j].join(" ")
						search_results = record_search(query)
						if !search_results.nil?
							return search_results
							# 	throw :search_results
						end
					end
				end

				
						# scrape wiki

					# end
				# end


				search_results
			end

			def record_search phrase
				prelim = Artist.find_by(name: "#{phrase}")
				if prelim != nil
					artist = prelim.id
				else
					return nil
				end
			end


			def wiki_search phrase
				doc = Nokogiri::HTML(URI.open("https://en.wikipedia.org/wiki/#{phrase}"))

				if doc.at_css('table.infobox.vcard.plainlist') #infobox.biography.vcard
					table = doc.css('table.infobox.vcard.plainlist')
				elsif doc.at_css('table.infobox.biography.vcard')
					table = doc.at_css('table.infobox.biography.vcard')
				else
					return nil
				end

				genre = ""

				table.css('tr').each do |s|
					puts s.text
					if s.text.include? "Genres"
						genre = s.text 
					end
				end

				genre.to_str
				genre = genre.split(" ")
				genre[0] = genre[0].gsub("Genres", "")
				if genre[0] == ""
					genre.delete_at(0)
				end
				genre
			end

			def push_to_db

			end

		end
	end
end
