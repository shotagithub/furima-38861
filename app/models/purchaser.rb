class Purchaser < ApplicationRecord
  belongs_to :purchased_list

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
