class CreateFlags < ActiveRecord::Migration[5.2]
  def change
    create_table :flags do |t|
      t.references :flaggable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
