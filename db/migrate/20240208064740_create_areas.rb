class CreateAreas < ActiveRecord::Migration[6.1]
  def change
    create_table :areas do |t|
      t.references :user

      t.timestamps
    end
  end
end
