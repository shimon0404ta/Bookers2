class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # name：一意性を持たせ、かつ2～20文字の範囲で設定してください。
  validates:name,
    presence:true,
    length:{minimum:2,maximum:20},
    uniqueness:true
  # introduction：最大50文字までに設定してください。
  validates:introduction,
    length:{maximum:50}

  has_many :books,dependent: :destroy
  has_one_attached :image
  #attachment :profile_image

end