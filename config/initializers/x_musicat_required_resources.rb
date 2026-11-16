# If you change this file, restart the server.
Rails.application.config.to_prepare do
  if MusicatSettings.table_exists?
    if QueryMusicatSettings.get == nil
      if MusicatSettingsBuilder.new.build_and_save_default
        message = 'MusiCat: Database entry for MusicatSettings resource not found. Creating one with default settings.'
        Rails.logger.warn message
      else
        message = 'MusiCat: Database entry for MusicatSettings cannot be created. Has the database been initialized?'
        puts message
        Rails.logger.fatal message
      end
    end
  end
end
