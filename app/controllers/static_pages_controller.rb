class StaticPagesController < ApplicationController
  def home
    @days = Day.where(closed: false)
  end
end
