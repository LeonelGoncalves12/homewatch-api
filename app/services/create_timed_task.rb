# Service object to create timed tasks
class CreateTimedTask
  attr_reader :status

  def initialize(home:, params:, user:)
    @home = home
    @user = user
    @params = params.clone
    @cron = @params.delete(:cron)
    @status = false
  end

  def perform 
    puts "teste perfom 1"
    return unless @cron
    puts "teste perfom 2"
    perform_transaction

    timed_task
  end

  private

  attr_reader :home, :params, :cron, :timed_task, :user

  def perform_transaction
    puts "teste perform_transaction"
    ActiveRecord::Base.transaction do
      @timed_task = home.timed_tasks.build(params)
      create_job
  
      raise ActiveRecord::Rollback if timed_task.errors.count.positive?
    end
  end

  def create_job
    return unless timed_task.save
puts 'teste create'
    timed_task.delayed_job = timed_task.delay(cron: cron).applyTimed(@user, timed_task)


    @status = timed_task.save
  end

end
