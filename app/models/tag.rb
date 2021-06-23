# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :missions_tags, dependent: :restrict_with_exception
  has_many :missions, through: :missions_tags
end
