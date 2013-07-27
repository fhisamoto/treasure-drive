class TreasureDrive < Sinatra::Application
  register Sinatra::Async

  get '/' do
    "Hello"
  end
end