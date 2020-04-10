class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class Customer < ApplicationRecord
  has_many :orders
  has_many :tickets, through: :orders
  validates :name , presence:true
  validates :lastname ,presence:true
  validates :email, presence: true, email: true
  validates :email, uniqueness: true
end
