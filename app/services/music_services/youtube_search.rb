# MusicService::YoutubeSearch.execute!

module MusicServices 
	class YoutubeSearch
		class << self
			def execute! params
				response = send_json(params)
				parse_response(response)
				response
			end

			def send_json search_params=nil, max_results=10
				uri = URI(
					ENV["YT_BASE_SEARCH_API"] +
					"?part=snippet&maxResults=#{max_results}&q=#{search_params}&key=#{ENV['YT_API_KEY']}"
				)

				res = Net::HTTP.get_response(uri)
				response = res.body
				JSON.parse(response)
			end

			def parse_response response
				unless response["items"].nil?
					response["items"].map do |res|
						{
							id: res["id"]["videoId"],
							title: res["snippet"]["title"],
							thumbnail: res["snippet"]["thumbnails"]["default"]["url"]
						}
					end
				else
					puts "sorry, quota exceeded"
				end
			end
		end 
	end
end
