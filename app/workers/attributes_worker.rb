class AttributesWorker
  include Sidekiq::Worker
 	sidekiq_options retry: 1

  def perform params
  	MusicServices::Id3.execute!(params)
  end
end