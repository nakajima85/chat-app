class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  # presence: true を設ける⇨空の場合はDBに保存しない

  has_many :room_users
  has_many :rooms, through: :room_users
  # 上記の２行、上・room_usersとのアソシエーション。下・中間テーブルを介してのRoomとのアソシエーション
end
