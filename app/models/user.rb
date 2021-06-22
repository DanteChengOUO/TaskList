# frozen_string_literal: true

class User < ApplicationRecord
  has_many :missions, dependent: :destroy
  has_secure_password

  enum role: { user: 0, admin: 1 }

  # kaminali default mission in per page
  paginates_per 15

  validates :name, :role, :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: true
end
