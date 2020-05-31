class Setting < ApplicationRecord
  validates :user_id, :timed_tasks_not, :triggered_tasks_not, :theme, :language,  presence: true

  belongs_to :user 

end
