module MusicatTasks::Initialize


  INIT_TASKS = [
    'db:schema:load',
    'musicat:initialize:settings',
    'musicat:administrator:new'
  ]


  class NothingToDo < ::StandardError
  end


  module_function


  def all
    puts "\n"
    puts '# MusiCat'
    puts "\n"
    puts '## Initializing'
    puts "\n"
    INIT_TASKS.each do |task|
      puts "#{'###'} #{task}"
      Rake::Task[task].invoke
    end
    puts "\n\n"
    puts '## Done with initialization tasks.'
    puts "\n"
  end


  def musicat_settings
    begin
      musicat_settings = QueryMusicatSettings.get
      if musicat_settings == nil
        musicat_settings = MusicatSettingsBuilder.new.build_and_save_default
      end

      attributes = {}
      attributes.merge! MusicatTasks::Interaction.ask_for_attribute(musicat_settings, :artist_name)
      attributes.merge! MusicatTasks::Interaction.ask_for_attribute(musicat_settings, :artist_content_copyright_year_earliest)
      attributes.merge! MusicatTasks::Interaction.ask_for_attribute(musicat_settings, :artist_content_copyright_year_latest, options: ['blank = current year'])
      if attributes.empty?
        raise NothingToDo
      end

      musicat_settings.update!(attributes)
      puts 'MusiCat settings updated.'

    rescue ActiveRecord::RecordInvalid
      puts 'MusiCat settings not updated.'
      puts musicat_settings.errors.full_messages
    rescue ActiveRecord::RecordNotSaved
      puts 'MusiCat settings not updated.'
      puts musicat_settings.errors.full_messages
    rescue ActiveRecord::StatementInvalid
      puts 'Database entry for MusiCat settings cannot be created.'
      puts 'Has the database been initialized?'
    rescue NothingToDo
      puts 'Nothing to do.'
    end
  end


  def tasks
    puts "\n"
    puts '## Initialization tasks invoked by `rails musicat:initialize:all`'
    puts "\n"
    INIT_TASKS.each do |task|
      puts "  - #{task}"
    end
    puts "\n"
  end


end
