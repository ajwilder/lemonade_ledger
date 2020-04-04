Sale.all.each do |s|
  s.update_attributes(reusable_straw: 0, reusable_straw_bag: 0, donut: 0)
end
