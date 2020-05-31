# Service object to create homes
class UpdateStatistic
  attr_reader :status

  def initialize(statistic:, params:)
    @statistic = statistic
    @params = params.clone
    @status = false
  end


  def perform
    perform_transaction

    statistic
  end

  private

  attr_reader  :params, :statistic

  def perform_transaction
    ActiveRecord::Base.transaction do
      update_statistic
      raise ActiveRecord::Rollback if statistic.errors.count.positive?
    end
  end


  def update_statistic
    statistic.update(params)
    @status = statistic.save
  end


end
