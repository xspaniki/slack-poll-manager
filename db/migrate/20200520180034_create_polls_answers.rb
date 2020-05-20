class CreatePollsAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :polls_answers do |t|
      t.string :name
      t.references :poll, null: false, foreign_key: true

      t.timestamps
    end
  end
end
