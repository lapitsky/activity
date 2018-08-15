class Patient < ApplicationRecord
  include ActivityLogging

  validates :first_name, :last_name, :physician_name, presence: true
end
