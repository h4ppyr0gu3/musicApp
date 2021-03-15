module SongsHelper

# 	def initialize
# 		@browser = browser
# 	end

# 	def capybara_initializer
# 		args = []
# 		args << "–window-size=320,480"
# 		args << "–user-agent='Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36.'"

# 		agent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36"

# 		Capybara.register_driver :selenium_chrome do |app|  # :selenium_chrome_headless for production 
# 			Capybara::Selenium::Driver.new(app, browser: :chrome, header: { 'HTTP_USER_AGENT' => agent})
# 			options: Selenium::WebDriver::Chrome::Options.new(args: %w[screen_size: [320, 480] ])
# 		end

# 		Capybara.javascript_driver = :chrome
# 		Capybara.configure do |config|  
# 		  config.default_max_wait_time = 10 # seconds
# 		  config.default_driver = :selenium
# 		end

# 		browser = Capybara.current_session
# 		driver = browser.driver.browser
# 		browser
# 	end

# 	def paste_linkk
# 	end


end



# youtube api key AIzaSyCstM4C7m0fdRWJ2ZaenVLkrVC-zs3x_JU