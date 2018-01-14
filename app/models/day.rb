class Day < ApplicationRecord
  has_many :sales, dependent: :destroy
  validates :location, presence: true
  validates :cash_start, presence: true
  validates :large_start, presence: true
  validates :small_start, presence: true




end
