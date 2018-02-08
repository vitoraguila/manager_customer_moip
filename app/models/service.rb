class Service < ApplicationRecord
  has_many :order
  
  enum recurrence: { "monthly" => 0, "quarterly" => 1, "semester" => 2, "yearly" => 3, "onetime" => 4, "two_or_more_times" => 5 } 

  validates :name, :price, :recurrence, presence: true

  def role_recurrence
    if self.recurrence == 'monthly'
      'Mensal'
    elsif self.recurrence == 'quarterly'
      'Trimestral'    
    elsif self.recurrence == 'semester'
      'Semestral'
    elsif self.recurrence == 'yearly'
      'Anual'
    elsif self.recurrence == 'onetime'
      'A vista'
    else
      'Parcelado'
    end
  end
end
