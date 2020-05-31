# Service object to update triggered tasks
class UpdateTriggeredTask
  attr_reader :status

  def initialize(triggered_task:, params:, user:)
    @triggered_task = triggered_task
    @params = params.clone
    @status = false
    @user = user
  end

  def perform
    perform_transaction

    triggered_task
  end

  private

  attr_reader :triggered_task, :cron, :params, :user

  def perform_transaction
    ActiveRecord::Base.transaction do
      delete_old_job

      update_triggered_task

      raise ActiveRecord::Rollback if triggered_task.errors.count.positive?
    end
  end

  def delete_old_job
    triggered_task.delayed_job.destroy if triggered_task.delayed_job
  end

  def update_triggered_task
    triggered_task.update(params)

    triggered_task.delayed_job = triggered_task.delay(cron: POLLING_RATE_CRON).apply_if(@user, triggered_task)

    @status = triggered_task.save
  end
end
