class CreateBathHacksPosts < ActiveRecord::Migration[7.2]
  def change
    create_table :bath_hacks_posts do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
