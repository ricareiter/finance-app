class Movement < ApplicationRecord
    enum :typeof, {debt: 'debt', credit: 'credit'}

    belongs_to :user
    
    validates :date, comparison: {less_than_or_equal_to: proc {Date.current}}
    validates :description, presence: true, length: {maximum: 150}
    validates :value, presence: true
    validates :typeof, presence: true
    validate :balance_validate

    def self.balance 
        Movement.credit.sum(:value) - Movement.debt.sum(:value)
    end

    private

    def balance_validate
        return if credit?
        return if value.to_f <= Movement.balance
        errors.add :value, "Not enough credit"
    end
end
