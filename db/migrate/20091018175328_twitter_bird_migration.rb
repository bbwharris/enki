class TwitterBirdMigration < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.string :text, :twitter_username
      t.datetime :twitter_update_time
      t.timestamps
    end    
  end
  
  def self.down
    drop_table :tweets
  end
end