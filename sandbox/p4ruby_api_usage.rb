

# Please setup a perforce server / client to manipulate the 
# Please install p4 ruby API from, 

# SUG: avoid using hard-coded string 
# SUG: make functions, reusable module rather than stand alone scripts.



# continue to check the target folder
# can also be viewed as client root
# should read from server, local backup, also allow user input 
target_workspace =  'd:/zjc/wr2/perforce_sandbox_for_data_manager/' 





# create local database and also wrtie to the remote db, try mongodb?



# carry out basic task, generate log and report




require "P4"
template = "my-client-template"
client_root = 'c:\p4-work'
p4 = P4.new
p4.connect
begin
# Run a "p4 client -t template -o" and convert it into a Ruby hash
spec = p4.fetch_client( "-t", template )
# Now edit the fields in the form
spec[ "Root" ] = client_root
spec[ "Options" ] = spec[ "Options" ].sub( "normdir", "rmdir" )
# Now save the updated spec
p4.save_client( spec )
# And sync it.
p4.run_sync
rescue P4Exception
# If any errors occur, we'll jump in here. Just log them
# and raise the exception up to the higher level
p4.errors.each { |e| $stderr.puts( e ) }
raise
end