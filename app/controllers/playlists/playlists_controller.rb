class Playlists::PlaylistsController < ApplicationController
  def index
  	@playlists = User.find(current_user.id).playlists
	end

	def index_api
		playlists = User.find(current_user.id).playlists
		response = {playlists: []}
		playlists.each do |play|
			if play.name != 'favourites' && play.name != 'tracks'
				number = play.songs.count
				response[:playlists].push({name: play.name, playlist_id: play.id, song_count: number})
			end
		end
		render json: response
	end
	
  def show
  end

  def show_api
    @user = current_user.id
    playlist =  User.find(@user).playlists.find(params[:id])
    playlist_name = playlist.name
    users_tracks = playlist.songs
    items = []
    users_tracks.each do |s|
      if s.music_file.attached? 
        array = []
        s.artists.each do |a|
          array.push(a.name)
        end 
        artists = array&.join(", ")
        entry = {}
        entry["name"] = s&.song_name
        entry["artists"] = artists
        entry["yt"] = s.yt_title
        entry["src"] = url_for(s.music_file)
        entry["img"] = s.album_art_url
        entry["status"] = s.status
        entry["id"] = s.id
        items.push(entry)
      end
    end
    users = Playlist.find(params[:id]).users
    array = []
    
    users.each do |user|
      element = {}
      element["first_name"] = user.first_name
      element["last_name"] = user.last_name
      element["email"] = user.email
      array << element
    end
    response = {
      items: items,
      name: playlist_name,
      users: array
    }
    render json: response
  end

  def edit
  end

  def update
  	Playlist.find(params[:id]).update!(name: params[:name])
  end

  def create
  	User.find(current_user.id).playlists.create(create_params)
    render json: {success: "created"}
  end

  def add_song
  	PlaylistsTrack.create!(playlist_id: params[:playlist_id], song_id: params[:song_id])
  end

  def remove_song
  end

  def destroy
  	Playlist.find(params[:id]).delete
    render json: {success: "deleted"}
  end

  private

  def create_params
  	params.permit(:name)
  end

end