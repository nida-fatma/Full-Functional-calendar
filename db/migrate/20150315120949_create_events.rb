class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :start_time
      t.text :repeat
      t.integer :repeat_freq
      t.integer :duration, default: 2000

      t.timestamps null: false
    end
  end
end
