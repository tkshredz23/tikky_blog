namespace :config do
  desc "display the current environment of rake"
  task :current_env do
    puts "You are running rake task in #{Rails.env} environment"
  end

  desc "create and setup database"
  task prepare: :environment do
    puts "preparing database..."
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    puts "success!!"
  end

  desc "initialize database"
  task initialize: :environment do
    puts "initializing database..."
    Rake::Task["config:prepare"].invoke
    Rake::Task["db:schema:load"].invoke
    Rake::Task["db:seed"].invoke
    puts "success!!"
  end
end
