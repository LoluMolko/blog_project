class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true, null: false # can't be null
      t.references :article, foreign_key: true, null: false # can't be null
      t.timestamps
      t.index %i(user_id article_id), unique: true
      # can't give two likes to one article
    end
  end
end
