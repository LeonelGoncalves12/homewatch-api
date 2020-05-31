# Service object to create stats
class CreateStatistic
  attr_reader :status

  def initialize(user:, params:)
    @user = user
    @params = params.clone
    @status = false
  end

  def perform

    @statistic = user.statistics.build(params)
    ActiveRecord::Base.transaction do
      create_job_thing

      raise ActiveRecord::Rollback if statistic.errors.count.positive?
    end

    statistic
  end

  def performStat

    @statistic = user.statistics.build(params)
    ActiveRecord::Base.transaction do
      create_stat
      raise ActiveRecord::Rollback if statistic.errors.count.positive?
    end

    statistic
  end

  private

  attr_reader :user, :params, :statistic

  def create_job_thing
    return unless statistic.save

    @status = statistic.save
    statistic.delayed_job = statistic.delay(cron: '*/3 * * * *').apply(@user, params[:thingID])
    # statistic.apply(params[:thingID])

  end


  def create_stat
    return unless statistic.save

    @status = statistic.save
  end


end
