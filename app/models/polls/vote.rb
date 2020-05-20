class Polls::Vote < ApplicationRecord
  belongs_to :answer, class_name: 'Polls::Answer'
  delegate :poll, :poll_id, to: :answer

  validates :uid, presence: true
  validate :cant_vote_more_than_once, on: :create

  private

  def cant_vote_more_than_once
    answer = Polls::Answer.find(answer_id)
    votes = answer.poll.votes

    if votes.pluck(:uid).include?(uid)
      errors.add(:base, "Can't vote more than once.")
    end
  end
end
