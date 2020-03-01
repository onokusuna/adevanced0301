class AddtitleTobooks < ActiveRecord::Migration[5.2]
  def change#カラムの追加の際はファイルの中身を自分で記述しなければならない
  	add_column :books, :title, :string
  end
end
