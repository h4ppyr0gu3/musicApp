class Friends::FriendsController < ApplicationController
	before_action :authenticate_user!

	def index 
		@q = User.where(id: current_user.friendships.confirmed.pluck(:friend_id)).ransack(params[:q])
  	@users = @q.result(distinct: true)
		@requests = User.where(id: Friendship.where(friend_id: current_user.id, status: 0).pluck(:user_id))
	end

	def create
		ActiveRecord::Base.transaction do
			current_user.friendships.build(friend_id: params[:id], status: 1).save!
			Friendship.find_by!(user_id: params[:id], friend_id: current_user.id).update_attribute(:status, 1)
		end
	end

	def destroy
		Friendship.find_by(user_id: current_user.id, friend_id: params[:id], status: 1).delete
		Friendship.find_by(user_id: params[:id], friend_id: current_user.id, status: 1).delete
	end

end
