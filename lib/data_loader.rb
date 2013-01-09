class DataLoader
  def load 
    file = File.new(data_path, "r")
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

  def data_path
    File.join(File.dirname(__FILE__), "hanzi.txt")
  end
end
