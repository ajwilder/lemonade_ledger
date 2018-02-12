class Sale < ApplicationRecord
  belongs_to :day
  default_scope -> { order(created_at: :desc) }
  
end
