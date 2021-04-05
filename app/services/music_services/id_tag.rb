require 'id3tag'

module MusicServices
	class IdTag
		class << self

			def execute!

			end

			def something

				mp3info.open(Song.last.music_file) do |mp3_file|
			    ## ID3 tag
			    tag = mp3_file.id3v2_tag

			    ## add/update values
			    tag.artist = 'pradeep'
			    tag.album = 'programming'

			    # ## add album art image
			    # albumart = TagLib::ID3v2::AttachedPictureFrame.new
			    # albumart.mime_type = "image/png"
			    # albumart.description = "Media"
			    # albumart.type = TagLib::ID3v2::AttachedPictureFrame::Media
			    # albumart.picture = File.open("media.png", 'rb') { |f| f.read }

			    # tag.add_frame(albumart)

			    # ## save tags
			    mp3_file.save
				end

			end

		end
	end
end