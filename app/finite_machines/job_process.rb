
class JobProcess < FiniteMachine::Definition
  
  target_alias :job
  
  initial :requested

  events {
    event :acknowledge, {
      :requested          => :acknowledged,
      :requested_over_due => :acknowledged
    }
    event :check_status, {
      :requested          => :requested_over_due, if: -> { job.acknowledge_before < Time.now }
    }
  }

  callbacks {
    on_transition do |event|
      job.state = event.to
    end

    on_enter_acknowledged do |event, user|
      raise 'Must pass user into acknowledge method' unless user
      job.acknowledger = user
    end
  }
end
