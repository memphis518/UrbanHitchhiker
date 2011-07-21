class Trip < ActiveRecord::Base
  
  validates :origin,        :presence => true
  validates :destination,   :presence => true
  validates :trip_type,     :presence => true
  validates :name,          :presence => true
  validates :start_date,          :presence => true
  validates :start_date,
            :date => {:after_or_equal_to => Proc.new { Date.today } }
  validates :start_time,          :presence => true
  validates :transportation,:presence => true
  validates :user_id,       :presence => true
  
  belongs_to :user
  
  attr_protected :id
end
