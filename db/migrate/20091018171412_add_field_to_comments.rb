class AddFieldToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :alphabet, :string
  end

  def self.down
    remove_column :comments, :alphabet
  end
end
