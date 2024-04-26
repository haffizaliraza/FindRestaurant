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
    return 'active' if params[:tab].blank? && tab == 'overview'

    'active' if params[:tab] == tab
  end

  def show_content(tab)
    return 'd-block' if params[:tab].blank? && tab == 'overview'

    if params[:tab] == tab
      'd-block'
    else
      'd-none'
    end
  end

  def hotel_rating(id)
    scores = ActsAsNpsRateable::NpsRating.where(nps_rateable_id: id).pluck(:score)
    return 0.0 if scores.length < 1

    scores.sum.to_f / scores.size
  end

  def user_rating(id, hotel_id)
    rating = ActsAsNpsRateable::NpsRating.where(nps_rateable_id: hotel_id, rater_id: id)
    return 0 if rating.length < 1

    rating.last.score
  end
end
