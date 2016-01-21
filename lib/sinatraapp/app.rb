require 'sinatra/base'
require 'sinatra/contrib'
require 'slim'

require 'mysql2'
require 'mysql2-cs-bind'

require 'resque'
require 'sinatraapp/job'

module SinatraApp
  class Application < Sinatra::Base
    configure do
			set :bind, '0.0.0.0'
			set :public_folder, File.dirname(__FILE__) + '/../../public'
      set :root, File.dirname(__FILE__) + '/../../'
    end

    helpers do
      def db
	      return Thread.current[:sinatra_db] if Thread.current[:sinatra_db]
		  	  config ||= YAML.load_file(settings.root+"config.yaml")
		  		client = Mysql2::Client.new(
		  		  host: config['DB']['HOSTNAME'],
		  		  port: config['DB']['PORT'],
		  		  username: config['DB']['USERNAME'],
		  		  password: config['DB']['PASSWORD'],
		  		  database: config['DB']['DBNAME'],
		  		  reconnect: true
		  		)
		  		client.query_options.merge!(symbolize_keys: true)
		  		Thread.current[:sinatra_db] = client
		  		client
      end
	  end
    
    get '/' do
      Resque.enqueue(Job, "Hello")
      slim :index
    end
    
  end
end
