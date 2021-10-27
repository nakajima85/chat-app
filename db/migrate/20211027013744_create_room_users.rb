class CreateRoomUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :room_users do |t|
      t.references :room, null: false, foreign_key: true
      # t.references room, foreign_key: true  roomの前にコロン：も忘れずに！
      t.references :user, null: false, foreign_key: true
      # t.references user, foreing_key: true
      t.timestamps
    end
  end
end
