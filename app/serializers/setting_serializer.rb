# Serializer for scenario objects
class SettingSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :timed_tasks_not, :triggered_tasks_not, :theme, :language

end
