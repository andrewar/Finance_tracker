require "sqlite3"
require "optparse"

def add_position(info, db)
   position=info.split(",")
   db.execute "insert into positions values(NULL,?,?,?,?)", position
end

def current(name)
   rows = db.execute "select p_close from quotes where name=?", name
   rows.any? ? return rows[-1] : return 0
end

def position_summary(name)

   positions=db.execute "select * from positions where name=?", name
   positions.split("\n").each do |line|
       puts info
       info=line.split("|")
       share_count+=info[1]
       total_cost += info[2] + info[3]
   end
   total_val = share_count*current(name)

   puts "Shares: " + share_count + " Value: " + total_val + " Cost: " + total_cost:

end


options={}
OptionParser.new do |opts|
  opts.banner = "Usage: position [option] [data]"

  opts.on("-a","--add","Add new position") do |a|
     options[:add]=a
  end
  opts.on("-p","--print","Print history and summary for position") do |a|
     options[:print]=a
  end
end



db = SQLite3::Database.new "fin_db"
stocks = db.execute "select distinct(name) from positions"
