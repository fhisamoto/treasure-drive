class TreasureDrive < Sinatra::Application
  register Sinatra::Async

  def self.config
    config_file = File.read(File.join( File.dirname(__FILE__), 'config', 'google_drive.yml.erb'))
    @config ||= YAML.load(ERB.new(config_file).result)['production']
    @config
  end

  get '/' do
    "Hello"
  end
end