class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.text :text
      t.references :option, null: false, foreign_key: true
      t.references :survey, null: false, foreign_key: true

      t.timestamps
    end
  end
end
