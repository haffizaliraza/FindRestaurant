module ApplicationHelper
  def current_page?(options)
    options.include?(controller_path)
  end

  def hotel_options
    list = []
    Hotel.all.each do |hotel|
      list << [hotel.name, hotel.id]
    end
    list
  end
end
