class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :books, dependent: :destroy# has_manyだから子は複数形
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  # 応用④フォロー機能
  has_many :relationships# has_many :relationships, foreign_key: 'user_id'の意味。要はこれもuser_idを入り口にしてねっていうだけ
  # followingsとありますが、これはいまこのタイミングで命名
      # なので、補足を付け足す必要があります。through: :relationships は「中間テーブルはrelationshipsだよ」って設定
          # source: :followとありますが、これは「relationshipsテーブルのfollow_idを参考にして、followingsモデルにアクセスしてね」って事
  has_many :followings, through: :relationships, source: :follow# foregin_key = 入口、source = 出口
  # has_many :relaitonshipsの「逆方向」って意味です。
      # これはこのタイミングで命名したものです。勿論reverse_of_relationshipsなんて中間テーブルは存在しません。
          # なので、これも補足を付け足してやります。class_name: 'Relationship'で「relationsipモデルの事だよ〜」と設定
              # foreign_key: 'follow_id'ですが、「relaitonshipsテーブルにアクセスする時、follow_idを入口として来てね！」っていう事
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  # ４行目に行きます。has_many :followersもこのタイミングで命名してます。勿論、followersなんてクラス存在しません。
      # through: :reverses_of_relationshipで「中間テーブルはreverses_of_relationshipにしてね」と設定
          # source: :userで「出口はuser_idね！それでuserテーブルから自分をフォローしているuserをとってきてね！」と設定
  has_many :followers, through: :reverse_of_relationships, source: :user# foregin_key = 入口、source = 出口

  # フォローしようとしている other_user が自分自身ではないかを検証
  def follow(other_user)
      unless self == other_user# self には user.follow(other) を実行したとき user が代入されます。つまり、実行した User のインスタンスが self です
        self.relationships.find_or_create_by(follow_id: other_user.id)# 見つかれば Relation を返し、見つからなければ self.relationships.create(follow_id: other_user.id)
      end                                                             # としてフォロー関係を保存(create = new + save)することができます
  end

  # フォローがあればアンフォローしています
  def unfollow(other_user)
      relationship = self.relationships.find_by(follow_id: other_user.id)
      relationship.destroy if relationship# relationship が存在すれば destroy します！if文はこのように書けます！
  end

  # self.followings によりフォローしている User 達を取得し、include?(other_user) によって other_user が含まれていないかを確認
  # 含まれている場合には、true を返し、含まれていない場合には、false を返します
  def following?(other_user)
      self.followings.include?(other_user)# include=を含む
  end

  attachment :profile_image, destroy: false

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, presence: true, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}
end
