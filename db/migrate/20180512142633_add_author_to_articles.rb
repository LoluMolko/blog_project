class AddAuthorToArticles < ActiveRecord::Migration[5.2]
  def change
    add_reference :articles, :author
    add_foreign_key :articles, :users, column: :author_id

    #moglibysmy napisac add_reference :articles, :user i by sie wszystko stalo automatycznie
  end
end
