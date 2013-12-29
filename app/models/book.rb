class Book < ActiveRecord::Base
  has_many :records, dependent: :destroy
  has_many :users, through: :records
  validates :isbn, presence: true,
                         length: {is: 13},
                         format: {with: /\A[+-]?\d+\Z/, message: "Only digits allowed"}
  validates :name, presence: true
  validates :author, presence: true
  validates :note, length: {maximum: 2000}
end
