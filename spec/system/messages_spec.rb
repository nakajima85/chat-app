require 'rails_helper'

RSpec.describe 'メッセージ投稿機能', type: :system do
  before do
    # 中間テーブルを作成して、usersテーブルとroomsテーブルのレコードを作成する
    @room_user = FactoryBot.create(:room_user)
  end

  context '投稿に失敗したとき' do
    it '送る値が空の為、メッセージの送信に失敗する' do
      # サインインする。@room_userへのuserが生成。よって@room_user.userアソシエ記述で取得
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する。上記同様。後、nameカラム値を取得しclick_onメソッドの引数にし
      # チャットルームの名前のリンクをクリック
      click_on(@room_user.room.name)

      # DBに保存されていないことを確認する
      expect{
        find('input[name="commit"]').click
      }.not_to change { Message.count }
      # 元のページに戻ってくることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room))
    end
  end

  context '投稿に成功したとき' do
    it 'テキストの投稿に成功すると、投稿一覧に遷移して、投稿した内容が表示されている' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 値をテキストフォームに入力する
      post = "Rspecテスト"
      fill_in "message_content", with: post

      # 送信した値がDBに保存されていることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room))

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)
    end

    it '画像の投稿に成功すると、投稿一覧に遷移して、投稿した画像が表示されている' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 添付する画像を定義する
      image_path = Rails.root.join("public/images/test_image.png")

      # 画像選択フォームに画像を添付する
      attach_file("message[image]", image_path, make_visible: true)
      # CSSでdisplay:none;設定のinput要素は非表示になるため、この状態のinput要素に画像を添付するには
      # attach_fileメソッドのmake_visibleオプションを使用する・・・補足

      # 送信した値がDBに保存されていることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room))

      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector("img")
    end

    it 'テキストと画像の投稿に成功する' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 添付する画像を定義する
      image_path = Rails.root.join("public/images/test_image.png")

      # 画像選択フォームに画像を添付する
      attach_file("message[image]", image_path, make_visible: true)

      # 値をテキストフォームに入力する
      post = "Rspecテスト"
      fill_in "message_content", with: post

      # 送信した値がDBに保存されていることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)

      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector("img")


      # have_selectorで確認すると、一覧表示画面に遷移できているかどうかが確認できるため
      # current_pathなどでの確認は不要

      
    end
  end
end

