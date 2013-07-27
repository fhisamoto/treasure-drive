require './treasure_drive'

class Web < Sinatra::Application
  register Sinatra::Async

  include TreasureDrive

  get '/' do
    ntn_b_file = google_drive_session.file_by_title('ntn-b')
    s = Roo::Google.new(ntn-b.key, :user => google_drive_config['email'], :password => google_drive_config['password'])
    s.info
  end
end