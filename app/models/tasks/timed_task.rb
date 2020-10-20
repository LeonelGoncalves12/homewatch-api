# This class represents the timed task model, a task that is applied on a given schedule
class Tasks::TimedTask < ApplicationRecord
  include Task
  require 'one_signal'
  require 'json'

  def cron
    delayed_job&.cron
  end

def applyTimed(user, timed_task)

  apply


  @paramms = ActionController::Parameters.new({statistic: {
      timed_task: timed_task.id
  }})
  create_statistic_service = CreateStatistic.new(user: user, params: statistic_params_timed)
  statistic = create_statistic_service.performStat
  statistic.save


  setting = Setting.select('timed_tasks_not AS timed_tasks_not').where(:user_id => user.id).first.timed_tasks_not

  isActive = ActiveModel::Type::Boolean.new.cast(setting)

  if isActive

    api_key=ENV['ONESIGNAL_API_KEY']
    user_auth_key=ENV['ONESIGNAL_USER_AUTH_KEY']
    app_id =ENV['ONE_SIGNAL_APP_ID']


    puts 'api_key: '
    puts api_key
    puts 'user_auth_key: '
    puts user_auth_key
    puts 'app_id: '
    puts app_id


    # configure OneSignal
    OneSignal::OneSignal.api_key = api_key
    OneSignal::OneSignal.user_auth_key = user_auth_key

    params = {"app_id" => app_id, 
            "contents" => {"en" => "Timed Task has been executed."},
            "filters" => [
                {"field": "tag", "key": "user", "relation": "=", "value": user.id}, 
              ]
      }
      
      puts 'params'
      puts params
    begin
      response = OneSignal::Notification.create(params: params)
      setting_id = JSON.parse(response.body)["id"]
    rescue OneSignal::OneSignalError => e
      puts "--- OneSignalError  :"
      puts "-- message : #{e.message}"
      puts "-- status : #{e.http_status}"
      puts "-- body : #{e.http_body}"
    end

  end
end

  def statistic_params_timed
    statistic_params_timed = @paramms.require(:statistic).permit(:timed_task)

    statistic_params_timed.permit!
  end
end
