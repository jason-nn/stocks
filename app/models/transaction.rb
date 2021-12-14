class Transaction < ApplicationRecord
  belongs_to :user

  validates :action, presence: true
  validates :amount,
            presence: true,
            numericality: true,
            numericality: {
              greater_than: 0,
            }
  validates :user_id, presence: true

  validates :action,
            inclusion: {
              in: ['cash in', 'purchase', 'sale'],
              message: '%{value} is not a valid action',
            }
end
