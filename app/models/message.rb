class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_one_attached :image

  validates :content, presence: true, unless: :was_attached?
  # のちのRSpecでテストするvalid?類

  def was_attached?
    self.image.attached?
  end


end
