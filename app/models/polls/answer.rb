class Polls::Answer < ApplicationRecord
  belongs_to :poll
  has_many :votes, class_name: 'Polls::Vote', dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: [:poll_id] }
end
