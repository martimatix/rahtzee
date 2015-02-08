class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :country
      t.string :gravatar_url
      t.text :about_me
      t.timestamps
    end
  end
end
