module MusicServices 
	class Attributes
		class << self

			def execute! title
				logic(title)
			end

			def logic title 
				hash_array = []
				artists = []
				artist_id = []
				genres = ''
				title_hashes = MusicServices::CleanTitle.execute!(title)
				title_hashes.each do |k, v|
					v.each do |el|
						value = MusicServices::ArtistScraper.execute!(el)
						value.each do |element|
							if element.class == String
								artists.push(element)
							elsif element.class == Hash
								hash_array.push(element)
							end
						end
					end
				end
				something = artists.each do |element|
					hash_array.each do |k, v|
						if k == element
							genres = v
						end
					end
					found = Artist.find_or_create_by(name: "#{element}")   #  find_or_create_by
					artist_id.push(found.id)
				end
				songname = []
				title_hashes.each do |k, v|
					v.each do |el|
						songname.push(el.gsub(Regexp.union(artists),''))
					end
				end
				songname = songname.map{ |v| v.strip}
				songname = songname.reject{ |v| v == ""}
				return songname, artists, artist_id
			end
		end
	end
end

# Song.first.update(artist_ids: [2, 4, 5, 6])
# Song.first.update(artists: Artist.where(asdasd))
# Song.first.update(artists: [Artist.first, Artist.second])

