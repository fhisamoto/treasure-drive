require './treasure_drive'

class Web < Sinatra::Application
  register Sinatra::Async

  include TreasureDrive

  get '/' do
    ntn_b_file = google_drive_session.file_by_title('ntn-b')
    s = google_drive_session.spreadsheet_by_key(ntn_b_file.key)
    s.tables.join(" ")
  end
end