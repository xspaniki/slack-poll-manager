class Poll < ApplicationRecord
  has_many :answers, class_name: 'Polls::Answer', dependent: :destroy
  has_many :votes, through: :answers

  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :name, presence: true
  validate :cant_be_without_answers

  private

  def cant_be_without_answers
    if answers.blank?
      errors.add(:base, "Can't be without answers.")
    end
  end
end
