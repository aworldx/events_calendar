class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :occurance_date
      t.references :user
      t.string :repeat_interval
      t.json :settings, default: {}
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
