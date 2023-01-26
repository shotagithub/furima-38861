class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validation
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥々ー－]+\z/.freeze
  VALID_RUBY_REGEX = /\A[ァ-ヶー－]+\z/.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX }
  validates :nick_name, presence: true
  validates :family_name, presence: true, format: { with: VALID_NAME_REGEX }
  validates :first_name, presence: true, format: { with: VALID_NAME_REGEX }
  validates :family_name_ruby, presence: true, format: { with: VALID_RUBY_REGEX }
  validates :first_name_ruby, presence: true, format: { with: VALID_RUBY_REGEX }
  validates :birth_date, presence: true
end
