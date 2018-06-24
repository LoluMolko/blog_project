class CreatePromotions < ActiveRecord::Migration[5.2]
  def change
    create_table :promotions do |t|
      t.integer :company_id
      t.integer :article_id
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
