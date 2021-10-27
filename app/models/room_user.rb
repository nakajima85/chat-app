class RoomUser < ApplicationRecord
  belongs_to :room
  belongs_to :user
end
# ”誰がどこに参加しているか”を管理するのが中間テーブルの役目
# belongs_toは相手_idが空ではないか？のバリデーション(validates)がデフォなので
# validates :相手, presence: trueの記述は不要