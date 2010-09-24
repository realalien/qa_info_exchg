
# * not using standalone tool like Ant build.xml, python/ruby/perl script
#   because most the tasks require double checking and data communications
#   and even exception handling, read stdout and stderr, even timeout functions.
# * 


require 'fileutils'

#FileUtils.mv('/tmp/your_file', '/opt/new/location/your_file')




require 'logger'  # TODO : logging

module Alice2

class ExecutionAgent
    
    def execute_batch_file(file)
        
    end
        
    def execute_rake_task
        
    end
    
    def execute_ruby_script
    end
    
    def execute_python_script
    
    end

end

class AuditingAgent
    
    def new_artifacts_generated?
        
    end
    
    def new_aritifacts_up_and_running?
        # on_pc_test_run
        # on_x360_test_run
        # on_ps3_test_run
    end
    
end


class PackagingAgent

    def prepare_daily_release
    end
    
    def prepare_weekly_build
    end

    def ensure_backup_files
    end

end

class P4Util
end


class Alice2DataManager

    #def check_responsiblities  ; end
    #def check_schedule  ; end

    def up_and_running
        # listen to incoming setting and change behaviors
        
    end
end

end


# TODO: also create a state machine in order to visualize the process and 
#       give slave intelligence to do by itself.




# SUG: design the APIs in order to allow the complex operations and process 
#      work smoothly

require 'rubygems'
require 'statemachine'

# Notes:
# * For state machine usage and tutorial,
#   see: http://slagyr.github.com/statemachine/example2.html

# TODO: allow user to switch on/off some parameters to work flexibly.

class BuildSlaveContext
    
    attr_accessor :statemachine

    def initialize
        @continue_building = true
    end

    def prelude_build_script
        3.times do
            puts "prelude_build_script..."  
            sleep 1
        end
    end
    
    def check_and_verify_prerequisite
    
    end
    
    def check_and_verify_artifacts_and_submit
    
    end
    
    # TODO: ask for confirmation 
    def reset_and_clean
        @continue_building = true
        ea = ExecutionAgent.new(a_batch_file)
    
        puts "clean workspace..."
    end
end

artifacts_build_process = Statemachine.build do

    # should also allow the intterrupted process to continue.

    trans :sleeping,        :start_to_work,     :build_cpp,   :reset_and_clean
    

    state :build_cpp do 
        event :confirm_build_cpp_pass, :build_script, :prelude_build_script  # Q: what if prelude takes time to execute, will it execute ahead of 
        # event :confirm_build_cpp_fail, :build_script, :prelude_build_script # transfer to super state like halt,
         
        on_entry :check_and_verify_prerequisite    # maybe turn on/off some switches
        on_exit  :check_and_verify_artifacts_and_submit # maybe turn on/off some switches
    end
    
    
    
    context BuildSlaveContext.new
end


artifacts_build_process.context.statemachine = artifacts_build_process


# should act like an engine
cnt = 0 
while true
    
    puts artifacts_build_process.state
    
    if cnt == 3
        artifacts_build_process.start_to_work
    end
    
    if cnt == 6 
        artifacts_build_process.send :confirm_build_cpp_pass
    end
    
    # added timeout facilities here
    
    
#    artifacts_build_process.start_to_work
#    puts artifacts_build_process.state
#    artifacts_build_process.confirm_build_cpp_ok
#    puts artifacts_build_process.state

    sleep(3)
    cnt += 1
end 
