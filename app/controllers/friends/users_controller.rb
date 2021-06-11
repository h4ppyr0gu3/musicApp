class Friends::UsersController < ApplicationController

	attr_accessor :id

	def index 
		@q = User.ransack(params[:q])
  	@users = @q.result(distinct: true)
	end

	def create
		current_user.friendships.build(friend_id: params[:id]).save!
	end

	def destroy
		Friendship.find_by(user_id: params[:id], friend_id: current_user.id).update_attribute(:status, 2)
	end

end