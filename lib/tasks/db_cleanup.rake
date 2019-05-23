namespace :db_cleanup do
  desc "TODO"
  task clean: :environment do
    days = Day.where('created_at < ?', 14.day.ago)
    days.each do |d|
      d.destroy
    end
  end

end
