class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :article, null: false, foreign_key: true
      t.string :body
      t.references :author, null: false, foreign_key: { to_table: "users" }
      t.timestamps
    end
  end
end
