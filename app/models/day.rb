class Day < ApplicationRecord
  has_many :sales, dependent: :destroy
  validates :location, presence: true
  validates :cash_start, presence: true
  validates :large_start, presence: true
  validates :small_start, presence: true
  default_scope -> { order(created_at: :desc) }


  def previous_day
    if self.location != "Market Street" || self.location != "Night Market"
      Day.where('created_at < ?', self.created_at).where(location: self.location).first
    else
      market_day = Day.where('created_at < ?', self.created_at).where(location: "Market Street").first
      night_day = Day.where('created_at < ?', self.created_at).where(location: "Night Market").first
      if market_day.created_at > night_day.created_at
        market_day
      else
        night_day
      end
    end
  end

end
