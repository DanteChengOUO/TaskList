# frozen_string_literal: true

class User < ApplicationRecord
  has_many :missions, dependent: :destroy
  has_secure_password

  # kaminali default mission in per page
  paginates_per 15

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_confirmation, presence: true
end
