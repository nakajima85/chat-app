
class Room < ApplicationRecord
  
  has_many :room_users, dependent: :destroy# Roomとroom_users のアソシエーション
  has_many :users, through: :room_users
  # RoomとUsers のアソシエーションだがジェイウォークのため中間テーブルの room_users を仲介してアソシエーション

  has_many :messages, dependent: :destroy

  validates :name, presence: true
end
