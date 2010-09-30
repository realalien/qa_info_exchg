
require 'FileUtils'

module Alice2    
    # the role 
    class Builder
        
        @@workspaces_in_processing = []
        
        def initialize(wr)
            # formalized the strings as path strings
            if File.directory? wr
                @workspace = File.expand_path(wr)
                @@workspaces_in_processing << @workspace
            else
                # doing nothing
            end
        end
        
        def locked?
            for to_cmp_with in @@workspaces_in_processing - @workspace.to_a
                if to_cmp_with =~ @workspace
                    return true
                end
            end
            return false
        end
        
        
        def clean_workspace
            if @workspace and not locked?
                puts "the clean_workspace is NOT implemented "
                # AFM: 
                # TODO: still not working
                # FileUtils.rmdir Dir.pwd
            end
        end
        # IDEA: can I alias a method to rake task, even with a parameter?

 
        
        
        # a more generic form of clean
        # AFM: can use a rake task to allow user interface, modelling after Rails backbone rake handling?
        def clean(spec)
            # if spec is a rake task
            
            # if can be fall back on to one of instance methods
            
        end
        
        
    end  # of class Builder
    
end # of module Alice2



if __FILE__ == $0
    # TODO Temp function verify
    Alice::Builder.new("D:/zjc/wr/sandbox")
  
end