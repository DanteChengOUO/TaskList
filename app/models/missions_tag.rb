# frozen_string_literal: true

class MissionsTag < ApplicationRecord
  belongs_to :mission
  belongs_to :tag
end
