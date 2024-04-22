# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin_user?
    false
  end

  def customer?
    false
  end

  def self.fetch_descendants
    AdminUser.none
    Customer.none
    descendants.reduce({}) { |total, descendant| total.update(descendant.to_s.titleize => descendant.to_s) }
  end
end
