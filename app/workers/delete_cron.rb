class DeleteCron
  include Sidekiq::Worker

  def perform
  	delete_file
  end

	def delete_file
		youtube = Rails.root.join("/bin/rm_tmp").to_s
		title = %x{./#{youtube}}
	end
end
