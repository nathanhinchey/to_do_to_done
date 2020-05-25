class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.text :body
      t.text :options, array: true, default: []
      t.boolean :allow_multiple
      t.boolean :active

      t.timestamps
    end
  end
end
