def progress_bar( collection ) 
  
  counter = 0
  target = collection.length
  collection.each do |entry|
    
    
    
    
    print "[" 
    ((counter.to_f/target)*10).round.times { print "#" }
    ((1-counter.to_f/target)*10).round.times { print " " }
    print "]  "
    $stdout.flush
   
    yield entry
  
    print "\r"
    $stdout.flush
    
    counter = counter+1
    
  end
 end
