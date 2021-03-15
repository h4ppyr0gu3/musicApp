require 'open-uri'
require 'nokogiri'


module MusicServices 
	class Attributes
		class << self

			def execute!
				super_search("Jack Harlow")
			end

			def super_search title
				spill = title.split(" ")
				puts spill.count
				search_results = nil
				artist = 0
				spill.each do |t|
					possible = t.capitalize
					search_results = record_search(possible)
					if !search_results.nil?
						artist = t.capitalize
						break
					end
				end
				puts "something"
				# search_results = 0
				search_results
				puts search_results
				puts !search_results.nil?
				puts artist
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

				genre = 0

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
