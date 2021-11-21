class Reser < ApplicationRecord
  validates :people, presence: true
  validates :start, presence: true
  validates :stop, presence: true
  
  validate :start_end_check
  validate :schedule_cannot_be_in_the_past
  belongs_to :post 
  belongs_to :user
  
  def start_end_check
    if self.start.present? && self.stop.present? && self.start > self.stop 
      errors.add(:stop, "は開始日より前の日付は登録できません。") 
    end
  end
  
  def schedule_cannot_be_in_the_past
    if self.start.present? && self.stop.present? && self.start.past?
      errors.add(:start, "が過去の日付は指定できません。")
    end
    if self.start.present? && self.stop.present? && self.stop.past?
      errors.add(:stop, "が過去の日付は指定できません。")
    end
  end
  
  def date_gap
    if self.stop == self.start
      return 1
    else
      self.stop.to_date - self.start.to_date
    end
  end
end
