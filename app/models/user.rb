# frozen_string_literal: true

class User < ApplicationRecord
  has_many :missions, dependent: :destroy
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
