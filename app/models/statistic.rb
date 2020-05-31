# This class represents the user model
# Users are composed of their homes, things, scenarios and tasks
class Statistic < ApplicationRecord
  belongs_to :user
  belongs_to :delayed_job, class_name: "::Delayed::Job", dependent: :destroy


  def checkStatus
    thing.status
  end

  def apply(user, thingID)
    thing = Thing.find_by(id: thingID)

    if thing.type == "Things::Light" || thing.type == "Things::Lock" || thing.type == "Things::Thermostat"
      thingstatus = thing.status
      if thingstatus
        stat = Statistic.new
        stat.thingID = thingID
        stat.status = thingstatus.body_json
        stat.user_id = user.id
        stat.save
      end
    end

  end

  def CounterTimedTask(user, timed_task)

    stat = Statistic.new
    stat.user_id = user.id
    stat.timed_task = timed_task
    stat.save
  end


  def CounterTriggeredTask(user, triggered_task)

    stat = Statistic.new
    stat.user_id = user.id
    stat.triggered_task = triggered_task.id
    stat.save


  end


  def statistic_params_timed
    statistic_params_timed = @params.require(:statistic).permit(:timed_task, :cron, :counter)
    statistic_params_timed.permit!
  end

  def statistic_params_triggered
    statistic_params_triggered = @params.require(:statistic).permit(:triggered_task)
    statistic_params_triggered.permit!
  end
end 
