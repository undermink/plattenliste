require './app.rb'
require 'pp'

File.open("Musikdatei_singles.csv"){|f|
  f.each_line{|line|
    if line.length>2
      cols=line[0..-2].split(';')
      if cols.length>6
	pp cols
	if cols[13]==nil
		cols[13]='unbekannt'
	end
	u=Music.create({

	  :lfdnr=>cols[0],
	  :interpret=>cols[1],
	  :titel=>cols[2],
	  :record=>cols[3],
	  :size=>cols[4],
	  :seite=>cols[5],
	  :datum=>cols[6],
	  :label=>cols[7],
	  :no=>cols[8],
	  :ablage=>cols[9],
	  :dauer=>cols[10]+" min",
	  :anzahl=>cols[11],
	  :reihenfolge=>cols[12],
	  :name=>cols[13]})


	  #      exit
      end
    end
  }
}

