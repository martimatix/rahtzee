class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :country
      t.string :gravatar_url
      t.text :about_me
      t.string :password_digest
      t.boolean :is_admin, :default => false
      t.timestamps
    end
  end
end
