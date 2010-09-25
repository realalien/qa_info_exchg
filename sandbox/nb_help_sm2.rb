# tryout another state machine moduel
# ref, http://github.com/pluginaweek/state_machine

# TODO & IDEA, the hardcoded transitions are very rigid, see if possible to create a 
# ESP. TODO., because there is no implementation of thread in R1.8, 1.9, it looks hard to get .bat command output!
# SUG. VIP. Instead of reading subprocess executing the batch file, it would be
#          easy to read the .batch file and the execute according! What about environment vars?
#          The good news is no more trying to get output, for the target project, command will write log files!



require 'logger'  # TODO : logging

require 'rubygems'
require 'state_machine'

$LOG = Logger.new("nb_help_sm2.log", "daily")


# designed to be assemble after users' operation, avoiding transition hard coded.
# NOTES: avoid using array.
$BUILD_SETUP = {
  {:waiting_for_new_build => :sync_workspace }   =>  ["clean_workspace"]
  
}


# TODO: should check each 'do'( also the values of first-level $BUILD_SETUP for not missing operation handling )

$EVENTS_DRIVEN = {
    :clean_workspace  =>  { :ok => :start_nightly_build , :fail => :report}


}

# check rules





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
        around_transition do | build, transition, block|
          start = Time.now
          $LOG.info "Build...#{build.state}."
          block.call
          build.time_used += Time.now - start
          $LOG.info "#{build.time_used} used, Build into new state...#{build.state}."
        end
               
        
        # experimental, call before_transition by reading config
        $BUILD_SETUP.each do | key, val |
            key.each  do | trans_from, trans_end |  # several action may share same 'do' actions.
                puts "--------"
                puts trans_from
                puts trans_end
                puts val
                before_transition  trans_from => trans_end, :do => val  
            end
        end

#        $BUILD_SETUP.each do | key, val |
#              puts key[0]
#              puts "----------"
#              before_transition  key[] => key[key], :do => val  
#        end            

    
#        before_transition :waiting_for_new_build => :sync_workspace,  
#                          :do => [:clean_workspace ]
                          
                          
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
           def speed
             10
           end
        end


        
        # event requirement
        event :start_nightly_build do 
            transition :waiting_for_new_build => :sync_workspace 
        end
        
        
        after_transition :on => :timeout, :do => [:immediate_report, :pass_to_next_state_if_allowed ]
        after_transition :on => :exception, :do => [:immediate_report, :pass_to_next_state_if_allowed ]
        
        # TODO: 
        # * allow user to drag-n-drop the transition, not hard-coded.
        # * create 
    end
    
    
    def initialize
        @time_used = 0
        super()
    end
    
    
    # TODO:  such operation should be partly( because some customization part) to dynamic dispatch!
    # exclude the method_name from  $EVENTS_DRIVEN  presets to avoid bugs
    def clean_workspace
      begin
        2.times do 
          puts "cleaning workspace "
          sleep 1
        end
        raise NoMethodError.new "just fake an exception"
      rescue NoMethodError
        puts "Something might goes wrong...test if allow to go back to init"
        # self.send :start_nightly_build
        # TODO: add OK/ERROR handling facilities.
        # FALLback to previous one , retry and 
        puts "--------------------" ;puts this_method
        
        issue_next_op(this_method.to_sym)   #Q: use string or symbol ?
      end
      
    end
  
    def basic_check_workspace
      puts " basic_check_workspace ...  not been implemented."
      # ATTE: be cautious
    end
    
    def issue_next_op_from(event)
      self.send $EVENTS_DRIVEN[event.to_s]
    end
  
    # Q: can this method yield a block, so that I can customize some dynamic 
    def method_missing(name, *args)
      # super if ( name  or name.to_sym ) not in $EVENTS_DRIVEN.keys
      puts "#{name} has not been implemented...."
      # ATTE: be cautious
    end
  
    
    def this_method
      caller[0][/`([^']*)'/, 1]
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
    
        if cnt == 2
            v.start_nightly_build
        end
        cnt += 1
    end
    
end



# Q: how to implement a method_missing() for a instace of statemachine?  Espeically its a module method
# TODO: record execution time by logging and give promp
# TODO: 