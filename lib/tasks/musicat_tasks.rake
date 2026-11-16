module MusicatTasks
  require_relative 'concerns/musicat_tasks_interaction'
  require_relative 'musicat_tasks_administrator'
  require_relative 'musicat_tasks_initialize'
end


namespace :musicat do

  namespace :administrator do
    desc 'Edit an administrator account'
    task :edit => :environment do MusicatTasks::Administrator.edit end

    desc 'Delete an administrator account'
    task :delete => :environment do MusicatTasks::Administrator.delete end

    desc 'Index of administrator accounts'
    task :index => :environment do MusicatTasks::Administrator.index end

    desc 'New administrator account'
    task :new => :environment do MusicatTasks::Administrator.new end
  end

  namespace :initialize do
    desc 'Inititalize MusiCat'
    task :all => :environment do MusicatTasks::Initialize.all end

    desc 'Initialize MusiCat settings'
    task :settings => :environment do MusicatTasks::Initialize.musicat_settings end

    desc 'List tasks performed in musicat:init:all'
    task :tasks do MusicatTasks::Initialize.tasks end
  end

end
