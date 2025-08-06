class CreateUploads < ActiveRecord::Migration[8.0]
  def change
    create_table :uploads do |t|
      t.string :title
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.string :short_url

      t.timestamps
    end
  end
end
