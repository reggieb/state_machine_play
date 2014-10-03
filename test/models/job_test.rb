require 'test_helper'

class JobTest < ActiveSupport::TestCase
  
  def test_initial_state
    job = Job.create
    assert_equal :requested, job.state
  end
  
  def test_acknowledge
    job.acknowledge business_partner
    assert_equal business_partner, job.acknowledger
    assert_equal :acknowledged, job.state
  end
  
  def test_acknowledge_without_user
    assert_raise RuntimeError do
      job.acknowledge
    end
  end
  
  def test_acknowledge_when_already_acknowledged
    test_acknowledge
    assert_raise FiniteMachine::InvalidStateError do
      job.acknowledge business_partner
    end
  end
  
  def test_acknowledge_before_set_on_creation
    job = Job.create
    expected = (Time.now + Job::ACKNOWLEDGEMENT_PERIOD).to_date
    assert_equal expected, job.acknowledge_before.to_date
  end
  
  def test_check_status
    job.check_status
    assert_equal :requested, job.state.to_sym
  end
  
  def test_check_status_after_acknowledgement_period_expired
    job.acknowledge_before = 1.days.ago
    job.check_status
    assert_equal :requested_over_due, job.state.to_sym
  end
  
  def test_acknowledge_after_acknowledgement_period_expired
    test_check_status_after_acknowledgement_period_expired
    test_acknowledge
  end
  
  def job
    @job ||= jobs(:requested)
  end
  
end
