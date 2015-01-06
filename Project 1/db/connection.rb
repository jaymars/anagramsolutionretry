require 'active_record'

ActiveRecord::Base.establish_connection({
  :adapter => "postgresql",
  :host => "localhost",
  :username => "Joel",
  :database => "micro_blogs"
  })

  ActiveRecord::Base.logger = Logger.new(STDOUT)