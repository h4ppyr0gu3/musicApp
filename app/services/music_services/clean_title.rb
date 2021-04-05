module MusicServices 
	class CleanTitle
		class << self

			def execute! title 
				logic(title_clean(title))
			end

			def title_clean title
				title.to_s.encode('UTF-8', invalid: :replace, undef: :replace, replace: '')
				primary_hash ={} 
				cleaning = []
				cleaner = ["Official Lyric Video", "Official Video", "Official Music Video", "Lyrics", "Lyric Video", ",", "(Audio)", "(Official Audio)", "[Audio]", "(Directed by Cole Bennett)"]
				cleaner.each do |t| 
					if title.include? t.to_s
						title = title.sub(t.to_s, "")
					end
				end
				if title.include? "-"
					split_array = title.split "-"
					primary_hash[:first] = includes(split_array[0])
					primary_hash[:second] = includes(split_array[1])
					if split_array[2] != nil
						primary_hash[:third] = includes(split_array[2])
					end
				else
					primary_hash[:first] = includes(title)	
				end
				return primary_hash
			end

			def logic input
				input.each do |k, v|
					v.each do |el|
						el = includes(el)
					end
					v = deep_clean(v)
				end
			end

			def deep_clean array
				remove = ["()", "{}", "[]", "||"]
				remove.each do |j|
					array = array.map{ |k| k.gsub(j, "") }
				end
				array = array.map{ |k| k.gsub(" x ", " ")}
				array = array.map{ |k| k.gsub(" dior", " Dior")}
				array = array.map(&:strip)
				array.reject(&:blank?)
			end

			def includes string
				features = [" Featuring", " featuring", " ft.", " feat.", " feat", " ft", "Ft.", " FT.", " FT", "(featuring", "(ft.", "FEATURING", "(FEATURING", "(ft", "(feat", "(feat."]
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