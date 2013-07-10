require "sqlite3"

db = SQLite3::Database.new "fin_db"
stocks = db.execute "select distinct(name) from positions"


#stocks=["SO"]
scrape_url="http://download.finance.yahoo.com/d/quotes.csv?s="+stocks.join(",")+"&f=sl1op&e=.csv"

print scrape_url
cmd="|curl \"" + scrape_url+"\""
f = open(cmd)
result=f.read()
print result

time=DateTime.now
time.strftime("%m-%e-%y")

result.split(/\n/).each{ |record|
   info=record.split(/,/)
   info[0] = info[0].reverse.chomp('"').reverse.chomp('"')
   print "Name = " + info[0]

   db.execute "insert into quotes values ( NULL, ?, ?, ?, ?, '07-10-2013')", info

}
