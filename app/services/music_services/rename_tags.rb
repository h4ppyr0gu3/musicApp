# MusicServices::RenameTags.execute!
require 'capybara'
require 'capybara/dsl'

module MusicServices
	class RenameTags
		class << self

			def execute!
			end

			def config 
			def config
				my_driver = Capybara.register_driver :selenium_chrome do |app|
					# my_driver['browser.download.dir'] = DOWNLOAD_DIRECTORY
					profile = Selenium::WebDriver::Chrome::Profile.new
    			profile["download.default_directory"] = DOWNLOAD_PATH
					
					Capybara::Selenium::Driver.new(app,
						browser: :chrome,
						:desired_capabilities => Selenium::WebDriver::Remote::Capabilities.chrome(
							"javascriptEnabled" => true,
							'ChromeOptions' => {
								'prefs' => {
									'download.default_directory' => (Rails.root.join('app', 'files'))
								}
							}
						),
						profile: profile
					)
				end
				Capybara.javascript_driver = :webkit
				Capybara.configure do |config|  
				  config.default_max_wait_time = 10 # seconds
  				config.default_driver = :selenium
				end
				Capybara::Webkit.configure do |config|
					config.debug = true
					config.allow_unknown_urls
				end

				session = Capybara::Session.new(:selenium_chrome)
			end

			def find_true_tags
				browser.visit


		end
	end
end