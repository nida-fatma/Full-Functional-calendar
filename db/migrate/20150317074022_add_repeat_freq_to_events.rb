class AddRepeatFreqToEvents < ActiveRecord::Migration
  def change
    add_column :events, :repeat_freq, :integer
  end
end
