require 'open-uri'
require 'nokogiri'
# require 'httpclient'
# returns {artist: "artist name", "artist 2", featured_artist: "artist name", song_name: "songname (remix) untouched", genres: "list", "of", "genres" }

module MusicServices 
	class Attributes
		class << self

			Debug = "-----------------------------------------------------------------------------------------------------------------"

			def execute! title
				title_clean(title)
			end

			def title_clean title
				title.to_s.encode('UTF-8', invalid: :replace, undef: :replace, replace: '')
				primary_hash ={} 
				cleaning = []
				cleaner = ["Official Lyric Video", "Official Video", "Official Music Video", "Lyrics", "Lyric Video", ",", "(Audio)", "(Official Audio)"]
				cleaner.each do |t| 
					if title.include? t.to_s
						title = title.sub(t.to_s, "")
					end
				end
				if title.include? "-"
					split_array = title.split "-"
					pp split_array
					primary_hash[:first] = includes(split_array[1])
					primary_hash[:second] = includes(split_array[0])
				else
					primary_hash[:first] = includes(title)	
				end
				return logic(primary_hash), primary_hash
			end

			def logic primary
				pp primary[:first]
				params = {}
				prelim = 0
				query_array = []
				genres_hash = Hash.new
				primary.each do |k, v|
					v.each do |el|
						local = local_search(el)
						genres_hash = local[0].merge(genres_hash)
						wiki = wiki_search(el)
						extra = extra_search(el)
						genres_hash = wiki[0].merge(genres_hash)
						genres_hash = extra[0].merge(genres_hash)	
						query_array.push(local[1])
						query_array.push(wiki[1])
						query_array.push(extra[1])
					end
				end


				query_array = query_array.flatten.uniq
				# pp query_array

				query_array.each_with_index do |a, idx|
					query_array = query_array.each_with_index do |b, idxi|
						if idx != idxi
							if a.include? b
								query_array.delete(b)
							end
						end
					end
				end






				return genres_hash, query_array
			end

		
			def local_search title
				spill = title.split(" ")
				search_results = nil
				artists = []
				genres = []
				genres_hash = Hash.new
				genres_hash = {}
				query_array = []
				tab = spill.count
				artist_count = 0
				for i in 1..tab
					array = spill.each_cons(i).to_a
					ref = array.length
					for j in 0..(ref - 1)
						query = array[j].join(" ")
						search_results = record_search(query)
						if !search_results.nil?
							genres_hash[array] = search_results
							query_array.push(query)
							genres << search_results
							artist_count += 1
						end
					end
				end
				# proc or block in future improvements
				
				return genres_hash, query_array
			end

			def wiki_search title
				title = title.split
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
					for j in 0..(ref - 1)
						query = array[j].join("_")
						artist = array[j].join(" ")
						search_results = wiki_scraper(query)
						puts search_results
						if !search_results.nil? 
							genres_hash[artist] = search_results.join(" ")
							puts artist
							query_array.push(artist)
							search_results = nil
							break
						end
					end
				end
				pp genres_hash
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
						ref = search.length
						for j in 0..(ref - 1)
							# puts search
							query = search[j].join("_")
							query = query + "_(" + k + ")"
							artist = search[j].join(" ")
							search_results = wiki_scraper(query)
							# puts search_results
							if !search_results.nil? 
								genres_hash[artist] = search_results.join(" ")
								# puts artist
								query_array.push(artist)
								search_results = nil
								break
							end
						end
					end
				end
				return genres_hash, query_array
			end

			def record_search phrase
				prelim = Artist.find_by(name: "#{phrase}")
				if prelim != nil
					genres = prelim.genres
					return genres
				else
					return nil
				end
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
					genre.to_str
					genre = genre.split(" ")
					genre[0] = genre[0].gsub("Genres", "")
					puts genre
					if genre[0] == ""
						genre.delete_at(0)
					end
					genre
				rescue OpenURI::HTTPError, URI::InvalidURIError => ex
					# puts "error 404"
				end
			end


			def deep_clean array
				remove = ["()", "{}", "[]", "||"]
				remove.each do |j|
					array = array.map{ |k| k.gsub(j, "") }
				end
				array = array.map{ |k| k.gsub(" x ", " ")}
				array = array.map(&:strip)
				# array = array.map(&:strip)

				array.reject(&:blank?)
				# array = array.reject { |item| item == '' }
				# array.delete("")

				pp array
			end

			def includes string
				features = [" Featuring", " featuring", " ft.", " feat.", " feat", " ft", " FT.", " FT", "(featuring", "(ft.", "FEATURING", "(FEATURING", "(ft", "(feat", "(feat."]
				featuring =[]
				song = []
				array = []
				prelim = []
				features.each do |t|
					if string.include? t
						string = string.strip
						prelim = string.split(t)
						featuring = (deep_clean(prelim))
						return featuring
					end
				end
				string = string.strip
				return deep_clean([string]) 				
			end

		end
	end
end
