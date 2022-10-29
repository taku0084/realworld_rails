class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :slug, null: false
      t.string :title, null: false
      t.string :description, null: false
      t.string :body, null: false
      t.integer :favorites_count, null: false, default: 0
      t.references :author, null: false, foreign_key: { to_table: "users" }

      t.timestamps
    end
  end
end
