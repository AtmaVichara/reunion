class Activity

  attr_reader :name,
              :participants,
              :total_cost

  def initialize(name)
    @name = name
    @participants = {}
    @total_cost = 0
  end

  def add_participants(name, price)
    @participants.merge!({name => price})
  end

  def convert_cost_to_integer(participant)
    price = @participants[participant]
    price.gsub("$", "").gsub(".", "").to_i
  end

  def calculate_total_cost
    @total_cost = @participants.each_value.map do |value|
      (value.gsub("$", "").gsub(".", "")).to_i
    end.reduce(&:+)
  end

  def split_cost
    calculate_total_cost / @participants.count
  end

  def convert_split_cost_to_dollar_amount
    cost_array = split_cost.to_s.split('0')
    cost_array.unshift("$")
    cost_array.insert(2, '.')
    (cost_array.join).concat("00")
  end

  def calculate_amount_owed_or_owes(participant)
    paid_price = convert_cost_to_integer(participant)
    split_cost - paid_price
  end


end
