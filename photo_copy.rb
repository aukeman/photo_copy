require 'progressbar.rb'

def Usage()
  puts "Usage: $0 <source dir> <target dir>"
end

def generate_year_directory(filename)
  
  s = File.stat filename
  return sprintf("%04d", s.mtime.year)
end

def generate_day_directory(filename)
  
  s = File.stat filename
  return sprintf("%04d %02d %02d", s.mtime.year, s.mtime.month, s.mtime.day)
end

def generate_target_directory(sourceFile, dest)
  
  return "#{dest}/#{generate_year_directory(sourceFile)}/#{generate_day_directory(sourceFile)}"
end

if ($*.length != 2) then
  Usage()
  exit(1)
end

source = $*[0]
dest = $*[1]

if ( not (File.directory? source and File.directory? dest) ) then
  
  Usage()
  exit(1)
end

#
# main
#

Dir.open( source ) do |d|
  
  valid_files = d.select do |entry| 
    
    sourceFile = "#{source}/#{entry}" 
    destFile = "#{generate_target_directory(sourceFile, dest)}/#{entry}"
    
    File.exist?(sourceFile) and 
    File.file?(sourceFile) and 
    (entry != "Thumbs.db") and
    not File.exist?(destFile)
    
  end
                                
  counter = 1
  
  if ( valid_files.length == 0 ) then
    
    puts "No files to copy!"
  elsif ( 0 < (difference = (d.entries.length - valid_files.length)))
    
    puts "Skipping #{difference} files that are invalid or already exist"
  end
  
  # valid_files.each do |entry|
  
  progress_bar( valid_files ) do |entry|
  
    sourceFile = "#{source}/#{entry}"
    targetDir = generate_target_directory(sourceFile, dest)
    targetFile = "#{targetDir}/#{entry}"
      
    if (not File.directory? "#{dest}/#{generate_year_directory(sourceFile)}" ) then
      Dir.mkdir "#{dest}/#{generate_year_directory(sourceFile)}" 
    end
      
    if (not File.directory? targetDir) then
      Dir.mkdir targetDir
    end
        
    message="Copying #{counter} of #{valid_files.length}; #{targetFile}...                "

    col=`/usr/bin/tput cols`

    print message.slice(0,col.to_i-15)

    $stdout.flush
        
#    `xcopy /F /Y /I \"#{sourceFile}\" \"#{targetDir}\"` #windows-specific
    `/bin/cp --preserve=timestamps \"#{sourceFile}\" \"#{targetDir}\"`
        
    #print "\r" # carriage return
    #$stdout.flush
  
    counter += 1
  end
  
end
