
class Room < ApplicationRecord
  # Usersテーブルとのアソシエーション
  has_many :room_users # Roomとroom_users のアソシエーション
  has_many :users, through: :room_users
  # RoomとUsers のアソシエーションだがジェイウォークのため中間テーブルの room_users を仲介してアソシエーション
  validates :name, presence: true
end
