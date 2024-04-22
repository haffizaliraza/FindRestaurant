# frozen_string_literal: true

# View helper methods for Nav Items
#
module NavItemsHelper

  def admin_nav_list
    [
      { title: 'Dashboard', icon: 'fa-tachometer-alt', path: route.dashboard_path },
      { title: 'Users', icon: 'fa-users', path: route.admin_users_path },
      { title: 'Restaurents', icon: 'fa-utensils', path: route.admin_hotels_path },
      { title: 'Items', icon: 'fa-bowl-food', path: route.admin_products_path },
      { title: 'Deals', icon: 'fa-burger', path: route.admin_deals_path },
      { title: 'Locations', icon: 'fa-location', path: route.admin_locations_path }
    ]
  end

  def nav_items(user)
    user = user.class.name

    case user
    when 'AdminUser' then nav_items_list(admin_nav_list, true)
    else
      raise 'Invalid user for fetching nav list'
    end
  end

  def nav_items_list(list, _user_roles)
    nav_items = {}

    list.flat_map do |nav_item|
      nav_items.merge!(nav_item[:title].to_s => nav_item)
    end

    nav_items
  end

  private

  def route
    Rails.application.routes.url_helpers
  end
end
