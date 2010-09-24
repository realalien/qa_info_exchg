# tryout another state machine moduel
# ref, http://github.com/pluginaweek/state_machine


require 'logger'  # TODO : logging

require 'rubygems'
require 'state_machine'

module Alice2


class StateMachine
  
end


class Build

    attr_accessor :time_used
    attr_accessor :current_state

#  ---- customized guideline -----
# * before_transition is often used to determine the prerequisite of next state.
# * after_transition is often used to audit the previous state
# * SUG: make a every incident into a scriptable checking rule.

#  ----  states listing ----
# waiting_for_new_build
# build_cpp 
# 


#  ---- actions listing ( LX: long duration )---
# clean_workspace
# verify_prerequisite
# basic_check_workspace
# immediate_report
# pass_to_next_state_if_allowed



# ---- custom events listing   -----
# timeout
#
# 

    state_machine :state, :initial => :waiting_for_new_build do
    
        # State requirements callback
        
        before_transition :waiting_for_new_build => :sync_workspace, 
                          :do => [:clean_workspace ]
        # maybe block should be used to set attributes of instance of build.
        
        after_transition :waiting_for_new_build => :sync_workspace,
                         :do => [:basic_check_workspace]
        

        before_transition :sync_workspace => :build_cpp, 
                                  :do => [:clean_workspace , :verify_prerequisite]
        
        after_transition :sync_workspace => :build_cpp, 
                                          :do => [:clean_workspace , :verify_prerequisite]
        
        
        before_transition :build_cpp => :build_script, 
                                  :do => [:clean_workspace , :verify_prerequisite]
        
        after_transition :build_cpp => :build_script, 
                                          :do => [:clean_workspace , :verify_prerequisite]
        
        
        before_transition :build_script => :pre_compile_shader, 
                                         :do => [:clean_workspace , :verify_prerequisite]
               
        after_transition :build_script => :pre_compile_shader, 
                                         :do => [:clean_workspace , :verify_prerequisite]
        

        state :waiting_for_new_build , :sync_workspace do
        
        end


        
        # event requirement
        event :start_nightly_build do 
            transition :waiting_for_new_build => :sync_workspace 
        end
        
        
        after_transition :on => :timeout, :do => [:immediate_report, :pass_to_next_state_if_allowed ]
        after_transition :on => :exception, :do => [:immediate_report, :pass_to_next_state_if_allowed ]
        
    end
    
    
    def initialize
        @time_used = 0
        super()
    end
    
    def clean_workspace
      
    end
  
    def method_missing(name, *args)
      puts "#{name} has not been implemented...."
      # ATTE: be cautious
    end
  
    def basic_check_workspace
      puts "#{name} has not been implemented...."
      # ATTE: be cautious
    end
    

end  # of class

end # of module

#
# Q: how to add timeout facilities here?
# Q: how to read python object in memory in order to get info. from others' server.


if __FILE__ == $0
    v = Alice2::Build.new
    cnt = 0
    while true
       
       puts "#{v.state} ...#{v.state_name} "
       sleep 1
    
        if cnt == 3
            puts v.start_nightly_build
        end
        cnt += 1
    end
    
end



# Q: how to implement a method_missing() for a instace of statemachine?  Espeically its a module method
# TODO: record execution time by logging and give promp
# TODO: 