class TwitterBirdMigrationGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template 'migration.rb', 'db/migrate', :migration_file_name => "twitter_bird_migration"
    end
  end
end