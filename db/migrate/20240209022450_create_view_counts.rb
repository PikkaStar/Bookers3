class CreateViewCounts < ActiveRecord::Migration[6.1]
  def change
    create_table :view_counts do |t|
      t.references :user
      t.references :book

      t.timestamps
    end
  end
end
