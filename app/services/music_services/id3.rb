#doc ref id3 == https://id3.org/id3v2.3.0
require "image_processing"

module MusicServices
	class Id3
		class << self

			def execute! id
				song = Song.find(id)
				
				cat(
					song, 
					main(song), 
					id
				)
			end

			def main song
				tags = []
				title = text_tag("TIT2", song.song_name)
				tags << title
				
				artists = song.artists.pluck(:name)

				if artists.count > 1
					artists = artists.join("/") 
				else 
					artists = artists[0]
				end

				artists = text_tag("TPE1", artists)				
				tags << artists

				header = ""
				album_art = image_processing(song.album_art_url)

				album_art = image_tag(
					album_art[0], 
					album_art[1]
				)
				tags << album_art
				size = sum_header(tags)
				header = ["ID3", 4, 0, 0, size].pack("A3CCCB32")
				tag = header.force_encoding(Encoding::UTF_8) + tags.join 
			end

			# doc ref
			def cat song, header_tag, id
				mp3 = ''
				song.music_file.open do |bin|
					bin.seek(6)
					header = bin.read(4)
					header = find_header_size(bin)
					
					bin.seek(header)
					mp3 = bin.read
					spacer = [0].pack("C") * 1024
					mp3 = header_tag + spacer.force_encoding(Encoding::UTF_8) + mp3.force_encoding(Encoding::UTF_8)
					
					# IO.binwrite(bin, mp3)
				end

				File.write(
					Rails.root.join("tmp/downloads/#{song.id}.mp3"), 
					mp3, 
					mode: "wb"
				)

				song.music_file.purge
				song.music_file.attach(
				  io: File.open(Rails.root.join("tmp/downloads/#{song.id}.mp3")),
				  filename: "#{song.song_name}.mp3",
				  content_type: 'audio/mp3'
				)
			end

			def sum_header tags # expects an array of all the tags produced
				size = 1024
				tags.each do |tag|
					size = size + tag.length
				end
				
				size = size.to_s(2)
				for i in 1..(28 - size.length)
					size = "0" + size
				end
				
				size = size.split("")
				size.insert(0, "0")
				size.insert(8, "0")
				size.insert(16, "0")
				size.insert(24, "0")
				size.join
			end

			def image_processing url
				begin
					image = MiniMagick::Image.open(url)
				rescue Errno::ENETUNREACH, SocketError => e
					puts "Check connection, can't open url\nerror: #{e}"
					exit(1)
				end

				image.combine_options do |options|
				  options.crop(
				  	"300x300+#{ (image.width - 300) / 2 }+#{ (image.height - 300) / 2 }"
				  )
				end
				size = image.size
				image_file = File.open(image.path, "r+b") { |f| f.read }
				string = image_file.force_encoding(Encoding::UTF_8)
				[string, size]
			end

			def text_tag tag, title
				title = title.split("")
				title_length = title.length + 1
				title = title.map{ |t| [t].pack("A") }
				title = title.join
				title = "" + title

				title_length = title_length.to_s(2)
				count = 32 - title_length.length
				for i in 1..count
					title_length = "0" + title_length
				end

				string = begin
					[tag].pack("A4") + 
					[title_length].pack("B32") + 
					[0, 0, 0].pack("CCC") + 
					title
				end	

				string.force_encoding(Encoding::UTF_8)
			end

			def image_tag image, image_size
				mime_type = "image/jpeg"
				mime_type = [mime_type].pack("A10")
				mime_type = [0].pack("C") + mime_type + [0, 3, 0].pack("CCC")
				
				image_size = image_size + 16
				image_size = image_size.to_s(2)
				count = 32 - image_size.length
				
				for i in 1..count
					image_size = "0" + image_size
				end
				
				header = ["APIC", image_size, 0, 0].pack("A4B32CC")
				argument = begin
					header.force_encoding(Encoding::UTF_8) +
					mime_type.force_encoding(Encoding::UTF_8) + 
					image.force_encoding(Encoding::UTF_8)
				end
			end

			def find_header_size file
				header_size = seek_process(
					file, 
					6, 
					4, 
					"B8B8B8B8"
				).map{ |h| h.split("") }
				
				# wtf?
				header_size.each{ |h| h.shift }.flatten.join.to_i(2) + 10
			end

			def seek_process file, pos, length, string
				file.seek(pos)
				file.read(length).unpack(string)
			end

			def read_process file, length, string
				file
				.read(length)
				.unpack(string)
			end
		end
	end
end
