class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      # relationshipsテーブルは中間テーブルなので、user_idとfollow_idは「t.references」でカラムを生成してあげる必要があります。
      t.references :user, foreign_key: true
      t.references :follow, foreign_key: { to_table: :users }# follow_idの参照先のテーブルはusersテーブルにしてあげたいので、{to_table: :users}とする

      t.timestamps

      t.index [:user_id, :follow_id], unique: true# user_id と follow_id のペアで重複するものが保存されないようにするデータベースの設定
    end
  end
end
