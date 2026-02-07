class BathHacksPost < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 65_535 }

  belongs_to :user
end
