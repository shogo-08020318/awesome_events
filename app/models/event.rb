class Event < ApplicationRecord
  # event.rbの場合
  # アソシエーション :関連付け名, class_name: クラス名
  # eventモデルはuserモデルと「user」という関連付けの名前で紐づく
  # bolongs_to :user, class_name: 'User'
  # eventモデルはuserモデルと「owner」という関連付けの名前で紐づく
  belongs_to :owner, class_name: 'User'
  # こっちが子供、親のDNAを受け継いだファイル

  has_many :tickets, dependent: :destroy

  validates :name, length: { maximum: 50 }, presence: true
  validates :place, length: { maximum: 100 }, presence: true
  validates :content, length: { maximum: 2000 }, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validate :start_at_should_be_before_end_at

  def created_by?(user)
    return false unless user

    # unlessは, trueがfalse、falseがtrue
    # return false if user.nil?でもOK
    # owner_idはeventのカラム。schemaをみれば一目瞭然。
    owner_id == user.id
    # user&.id
  end

  private

  def start_at_should_be_before_end_at
    # 開始日と終了日が存在すればfalseなので、if文が実行される
    # 開始日と終了日が存在しなければ、returnが実行される
    # unlessは, trueがfalse、falseがtrue
    return unless start_at && end_at

    # 上記と等価
    # unless start_at && end_at
    #   return
    # end

    # return if !(start_at && end_at)
    # return unless true => false
    # return if start_at.blank? || end_at.blank?

    # 開始日と終了日を比較
    errors.add(:start_at, 'は終了時間よりも前に設定してください') if start_at >= end_at
  end
end
