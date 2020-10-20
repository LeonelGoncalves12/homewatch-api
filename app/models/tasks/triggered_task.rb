# This class represents the triggered task model, a task that is applied on a specific
# value change from another thing
class Tasks::TriggeredTask < ApplicationRecord
  include Task
  belongs_to :thing_to_compare, class_name: "Thing"
  validates :status_to_compare, :thing_to_compare, presence: true

  validate :status_to_compare_params_equals_thing_params
  validate :status_to_apply_params_equals_thing_params
  #validate :thing_to_compare_must_belong_to_home

  before_validation :trim_comparator

  def status
    status_to_apply
  end

  def status_to_compare
    self[:status_to_compare].symbolize_keys if self[:status_to_compare]
  end

  def  apply_if(user, triggered_task)
    comparison = thing_to_compare.compare(comparator, status_to_compare)

    if comparison && should_apply?
      apply

        @paramms = ActionController::Parameters.new({statistic: {
            triggered_task: triggered_task.id
        }})
        create_statistic_service = CreateStatistic.new(user: user, params: statistic_params_triggered)
        statistic = create_statistic_service.performStat
        statistic.save

        setting = Notification.select('triggered_tasks_not AS triggered_tasks_not').where(:user_id => user.id).first.triggered_tasks_not

      
        isActive = ActiveModel::Type::Boolean.new.cast(setting)
      
        if isActive
      
          api_key=ENV['ONESIGNAL_API_KEY']
          user_auth_key=ENV['ONESIGNAL_USER_AUTH_KEY']
          app_id =ENV['ONE_SIGNAL_APP_ID']
      
          # configure OneSignal
          OneSignal::OneSignal.api_key = api_key
          OneSignal::OneSignal.user_auth_key = user_auth_key
      
      
          params = {"app_id" => app_id, 
                  "contents" => {"en" => "Triggered Task has been executed."},
                  "filters" => [
                      {"field": "tag", "key": "user", "relation": "=", "value": user.id}, 
                    ]
            }
            
            puts params 
      
            
          begin
            response = OneSignal::Setting.create(params: params)
            setting_id = JSON.parse(response.body)["id"]
          rescue OneSignal::OneSignalError => e
            puts "--- OneSignalError  :"
            puts "-- message : #{e.message}"
            puts "-- status : #{e.http_status}"
            puts "-- body : #{e.http_body}"
          end
      
        end


      update_attribute(:should_apply?, false)
    elsif !comparison
      update_attribute(:should_apply?, true)
    end
  end

  private

  def status_to_compare_params_equals_thing_params
    return if thing_to_compare && status_to_compare && (status_to_compare.keys - thing_to_compare.returned_params).empty?

    errors.add(:status_to_compare, "not a valid status for this thing type")
  end


  def trim_comparator
    comparator.strip! if comparator
  end

  def statistic_params_triggered
    statistic_params_triggered = @paramms.require(:statistic).permit(:triggered_task)

    statistic_params_triggered.permit!
  end
end
