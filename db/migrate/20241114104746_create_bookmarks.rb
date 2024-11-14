class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.text :comment, null: false
      t.references :movie, null: false, foreign_key: { on_delete: :restrict }
      t.references :list, null: false, foreign_key: { on_delete: :cascade }
      t.timestamps
    end

    # Ajouter une contrainte d'unicité sur la combinaison movie_id et list_id
    add_index :bookmarks, [:movie_id, :list_id], unique: true
  end
end
