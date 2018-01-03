class Reunion

  attr_reader :location,
              :activities,
              :total_cost

  def initialize(location)
    @location = location
    @activities = []
    @total_cost = 0
  end

  def add_activity(activity)
    @activities << activity
  end

  def calculate_total_cost
    @total_cost = @activities.map { |activity| activity.total_cost }.reduce(&:+)
  end

  def calculate_total_owed_or_owes(name)
    @activities.map do |activity|
      activity.calculate_amount_owed_or_owes(name)
    end.reduce(&:+)
  end

end
