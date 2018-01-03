require 'minitest'
require 'minitest/pride'
require 'minitest/autorun'
require './lib/reunion'
require './lib/activity'

class ReunionTest < Minitest::Test

  def test_it_exists
    reunion = Reunion.new("Outside the Bank")

    assert_instance_of Reunion, reunion
  end

  def test_it_adds_activities
    reunion = Reunion.new("Outside the Bank")
    activity = Activity.new("Hiking")
    activity.add_participants("Josh", "$15.00")
    activity.add_participants("Jane", "$13.00")

    reunion.add_activity(activity)

    assert_equal 1, reunion.activities.count
    assert_instance_of Activity, reunion.activities.first
  end

  def test_it_can_calculate_total_cost_of_reunion
    reunion = Reunion.new("Iglootown")
    hiking = Activity.new("Hiking")
    comedy = Activity.new("Comedy Show")
    movie = Activity.new("Movie")

    hiking.add_participants("Josh", "$15.00")
    hiking.add_participants("Jane", "$13.00")
    comedy.add_participants("Josh", "$15.00")
    comedy.add_participants("Jane", "$13.00")
    movie.add_participants("Josh", "$15.00")
    movie.add_participants("Jane", "$13.00")

    reunion.add_activity(comedy)
    reunion.add_activity(hiking)
    reunion.add_activity(movie)

    reunion.activities.each do |activity|
      activity.calculate_total_cost
    end

    reunion.calculate_total_cost

    assert_equal 8400, reunion.total_cost
  end

  def test_it_calculates_whats_owed_in_total_to_each_person
    reunion = Reunion.new("Iglootown")
    hiking = Activity.new("Hiking")
    comedy = Activity.new("Comedy Show")
    movie = Activity.new("Movie")

    hiking.add_participants("Josh", "$15.00")
    hiking.add_participants("Jane", "$13.00")
    comedy.add_participants("Josh", "$15.00")
    comedy.add_participants("Jane", "$13.00")
    movie.add_participants("Josh", "$15.00")
    movie.add_participants("Jane", "$13.00")

    reunion.add_activity(comedy)
    reunion.add_activity(hiking)
    reunion.add_activity(movie)

    reunion.activities.each do |activity|
      activity.calculate_total_cost
    end

    assert_equal (-300), reunion.calculate_total_owed_or_owes("Josh")
    assert_equal 300, reunion.calculate_total_owed_or_owes("Jane")

  end

end
