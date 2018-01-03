require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/activity'

class ActivityTest < Minitest::Test

  def test_it_exists
    activity = Activity.new('Hiking')

    assert_instance_of Activity, activity
  end

  def test_it_has_a_name
    activity = Activity.new("Hiking")

    assert_equal  "Hiking", activity.name
  end

  def test_it_has_participants
    activity = Activity.new("Hiking")
    activity.add_participants("Josh", "$15.00")

    assert_instance_of Hash, activity.participants
    assert activity.participants.has_key?("Josh")
    assert_equal "$15.00", activity.participants["Josh"]
  end

  def test_it_takes_in_multiple_participants
    activity = Activity.new("Hiking")
    activity.add_participants("Josh", "$15.00")
    activity.add_participants("Jane", "$13.00")
    activity.add_participants("Rolf", "$10.00")
    activity.add_participants("Kelly", "$18.00")

    assert_equal 4, activity.participants.count
    assert activity.participants.has_key?("Kelly")
    assert activity.participants.has_key?("Rolf")
    assert activity.participants.has_key?("Jane")
    assert activity.participants.has_key?("Josh")
  end

  def test_it_converts_cost_to_integer
    activity = Activity.new("Hiking")
    activity.add_participants("Josh", "$15.00")
    activity.add_participants("Jane", "$13.00")


    assert_equal 1500, activity.convert_cost_to_integer("Josh")
    assert_equal 1300, activity.convert_cost_to_integer("Jane")
  end

  def test_it_evaluates_total_cost_based_upon_price_paid
    activity = Activity.new("Hiking")
    activity.add_participants("Josh", "$15.00")
    activity.add_participants("Jane", "$13.00")
    activity.add_participants("Rolf", "$10.00")
    activity.add_participants("Kelly", "$18.00")
    activity.calculate_total_cost

    assert_equal 5600, activity.total_cost
  end

  def test_it_splits_cost_evenly_between_participants
    activity = Activity.new("Hiking")
    activity.add_participants("Josh", "$15.00")
    activity.add_participants("Jane", "$13.00")
    activity.add_participants("Rolf", "$10.00")
    activity.add_participants("Kelly", "$18.00")

    assert_equal 1400, activity.split_cost
  end

  def test_it_coonverts_cost_to_dollar_format
    activity = Activity.new("Hiking")
    activity.add_participants("Josh", "$15.00")
    activity.add_participants("Jane", "$13.00")
    activity.add_participants("Rolf", "$10.00")
    activity.add_participants("Kelly", "$18.00")
    activity.split_cost

    assert_equal "$14.00", activity.convert_split_cost_to_dollar_amount
  end

  def test_it_calculates_what_someone_owes
    activity = Activity.new("Hiking")
    activity.add_participants("Josh", "$15.00")
    activity.add_participants("Jane", "$13.00")
    activity.add_participants("Rolf", "$10.00")
    activity.add_participants("Kelly", "$18.00")

    assert_equal (-100), activity.calculate_amount_owed_or_owes("Josh")
    assert_equal 100, activity.calculate_amount_owed_or_owes("Jane")
    assert_equal 400, activity.calculate_amount_owed_or_owes("Rolf")
    assert_equal (-400), activity.calculate_amount_owed_or_owes("Kelly")
  end

end
