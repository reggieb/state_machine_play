    class Job < ActiveRecord::Base
      
      ACKNOWLEDGEMENT_PERIOD = 5.days
      
      belongs_to :creator, class_name: 'User'
      
      belongs_to :acknowledger, class_name: 'User'

      validates :state, presence: true
      
      before_validation :configure_as_new, on: :create

      def initialize(attrs = {})
        super
        process.restore!(state.to_sym) if state.present?
      end
      
      delegate :acknowledge, :check_status, to: :process
      
      def process
        @process ||= new_job_process
      end
      
      
      private
      def new_job_process
        job_process = JobProcess.new
        job_process.target(self)
        job_process
      end
      
      def configure_as_new
        set_initial_state
        set_acknowledge_before
      end
      
      def set_initial_state
        self.state = process.current
      end
      
      def set_acknowledge_before
        self.acknowledge_before = Time.now + ACKNOWLEDGEMENT_PERIOD
      end


    end
