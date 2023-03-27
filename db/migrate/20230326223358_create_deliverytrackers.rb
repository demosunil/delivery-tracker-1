class CreateDeliverytrackers < ActiveRecord::Migration[6.0]
  def change
    create_table :deliverytrackers do |t|
      t.string :content
      t.date :arrivedate
      t.string :details
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end
end
