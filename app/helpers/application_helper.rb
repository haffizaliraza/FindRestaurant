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

  def dom_id_for_records(*records, prefix: nil)
    records.map do |record|
      dom_id(record, prefix)
    end.join("_")
  end

  def active_tab(tab)
    'active' if params[:tab] == tab
  end

  def show_content(tab)
    if params[:tab] == tab
      'd-block'
    else
      'd-none'
    end
  end
end
