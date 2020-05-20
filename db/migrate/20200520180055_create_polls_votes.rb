class CreatePollsVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :polls_votes do |t|
      t.references :answer, null: false, foreign_key: { to_table: :polls_answers }
      t.string :uid

      t.timestamps
    end
  end
end
