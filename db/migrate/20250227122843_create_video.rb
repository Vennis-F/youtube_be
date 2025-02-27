class CreateVideo < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :url
      t.references :user, foreign_key: true, index: true
      t.timestamps 
    end
  end
end
