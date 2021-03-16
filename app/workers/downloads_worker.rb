class DownloadsWorker
  include Sidekiq::Worker
 	# sidekiq_options retry: 1

  # def perform name, age
  # 	abc = DIR[]
  # 	return if abc.empty?

  # 	attach
  # end
end

# DownloadsWorker.perform_async
# DownloadsWorker.new.perform