require 'open-uri'
require 'nokogiri'

module MusicServices 
	class ArtistScraper
		class << self

			def execute! title
				logic(title)
			end

			def logic title
				wiki = []
				wiki.push(wiki_search(title))
				wiki.push(extra_search(title))
				query  = []
				query.push(wiki[1][1])
				query.push(wiki[0][1])
				query = query.flatten
				query = query.uniq
				genres = []
				genres.push(wiki[0][0])
				genres.push(wiki[1][0])
				new_array = []
				query.each do |el|
					query.each do |element|
						if el != element
							if el.include? element
								new_array.push(element)
							end
						end
					end
				end
				query = query - new_array
				results = query + genres
				results
			end

			def wiki_search title
				spill = title.split(" ")
				search_results = nil
				artists = []
				genres = []
				tab = spill.count
				genres_hash = Hash.new
				query_array = []
				for i in 1..tab
					array = spill.each_cons(i).to_a
					ref = array.length
					for j in 0..(ref-1)
						query = array[j].join("_")
						artist = array[j].join(" ")
						search_results = wiki_scraper(query)
						if !search_results.nil? 
							genres_hash[artist] = search_results.join(" ")
							query_array.push(artist)
							search_results = nil
							next
						end
					end
				end
				return genres_hash, query_array
			end

			def extra_search title
				genres_hash = Hash.new
				query_array = []
				spill = title.split(" ")
				array = ["musician", "rapper", "group", "band"]
				search_results = nil
				artists = []
				genres = []
				tab = spill.count
				array.each do |k|
					for i in 1..tab
						search = spill.each_cons(i).to_a
						search.each do |v| 
							v.delete_if {|a| a == "" }
						end
						ref = search.length
						for j in 0..(ref - 1)
							query = search[j].join("_")
							query = query + "_(" + k + ")"
							artist = search[j].join(" ")
							search_results = wiki_scraper(query)
							if !search_results.nil? && !search_results.blank?
								genres_hash[artist] = search_results.join(" ")
								query_array.push(artist)
								search_results = nil
								next
							end
						end
					end
				end
				return genres_hash, query_array
			end

			def wiki_scraper phrase
				begin
						url = "https://en.wikipedia.org/wiki/#{phrase}"
						url =  url.to_s.encode('ASCII', invalid: :replace, undef: :replace, replace: '')
						doc = Nokogiri::HTML(URI.open("#{url}"))
					if doc.at_css('table.infobox.vcard.plainlist') #infobox.biography.vcard
						table = doc.css('table.infobox.vcard.plainlist')
					elsif doc.at_css('table.infobox.biography.vcard')
						table = doc.at_css('table.infobox.biography.vcard')
					else
						return nil
					end
					genre = ""
					table.css('tr').each do |s|
						if s.text.include? "Genres"
							genre = s.text 
						end
					end
					if genre != ""
						genre.to_str
						genre = genre.split(" ")
						genre[0] = genre[0].gsub("Genres", "")
						if genre[0] == ""
							genre.delete_at(0)
						end
					end
					genre
				rescue OpenURI::HTTPError, URI::InvalidURIError => ex
				end
			end
		end
	end
end
