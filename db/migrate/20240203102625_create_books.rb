class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.references :user

      t.timestamps
    end
  end
end