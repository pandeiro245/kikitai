class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :screen_name
      t.string :name
      t.string :twitter_id
      t.text :description
      t.boolean :protected
      t.text :raw
      t.integer :followers_count
      t.integer :friends_count
      t.string :twitter_token
      t.string :twitter_secret

      t.timestamps
    end
  end
end
