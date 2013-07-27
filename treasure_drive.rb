module TreasureDrive
  def get_files
    session = google_drive_session
    urls.each_pair do |title, url|
      content = donwload_ssl_verify_none(url)
      if session.file_by_title(title)
        session.upload_from_string(content, title, :content_type =>  "application/vnd.ms-excel")
      else
        session.update_from_string(content, title, :content_type =>  "application/vnd.ms-excel")
      end
    end
  end

  def google_drive_session
    @google_drive_session ||= GoogleDrive.login(google_drive_config['email'], google_drive_config['password'])
  end

  def google_drive_config
    erb = File.join(File.dirname(__FILE__), 'config', 'google_drive.yml.erb')
    @google_drive_config ||= YAML.load(ERB.new(File.read(erb)).result)['production']
  end

  def urls
    @urls ||= {
      'lft' => 'https://www.tesouro.fazenda.gov.br/images/arquivos/artigos/LFT_2013.xls',
      'ltn' => 'https://www.tesouro.fazenda.gov.br/images/arquivos/artigos/LTN_2013.xls',
      'ntn-c' => 'https://www.tesouro.fazenda.gov.br/images/arquivos/artigos/NTN-C_2013.xls',
      'ntn-b' => 'https://www.tesouro.fazenda.gov.br/images/arquivos/artigos/NTN-B_2013.xls',
      'ntn-b_principal' => 'https://www.tesouro.fazenda.gov.br/images/arquivos/artigos/NTN-B_Principal_2013.xls',
      'ntf' => 'https://www.tesouro.fazenda.gov.br/images/arquivos/artigos/NTN-F_2013.xls'
    }
  end

  def donwload_ssl_verify_none(url)
    uri = URI(url)
    req = Net::HTTP::Get.new(uri.path)
    res = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https',
                                              :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |https|
      https.request(req)
    end
    res.body
  end
end