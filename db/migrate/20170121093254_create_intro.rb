class CreateIntro < ActiveRecord::Migration[5.0]
  def change
    crate_table :intros do |t|
      t.string
      t.string
      t.text
      t.string
    end
  end
end
