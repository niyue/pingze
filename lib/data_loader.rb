class DataLoader
  def load 
    file = File.new(data_path('hanzi.txt'), "r")
    chars = {}
    while(line = file.gets)
      char = line.split  
      unless line.include?('#')
        ch = char[0]
        pinyin = char[1]
        chars[ch] = pinyin
      end
    end
    chars
  end

	def reference
    file = File.new(data_path('chuci.txt'), "r")
    reference = ''
    while(line = file.gets)
			reference += line
		end
		reference
	end

  def data_path(file)
    File.join(File.dirname(__FILE__), file)
  end

end
