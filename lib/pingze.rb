#!/bin/env ruby
# encoding: utf-8

require 'data_loader'
require 'set'

class Pingze
  VERSION = "1.0.0"
  YIN_PING    = Set.new ['ā', 'ē', 'ī', 'ō', 'ū']
  YANG_PING   = Set.new ['á', 'é', 'í', 'ó', 'ú', 'ǘ']
  SHANG_SHENG = Set.new ['ǎ', 'ě', 'ǐ', 'ǒ', 'ǔ', 'ǚ']
  QU_SHENG    = Set.new ['à', 'è', 'ì', 'ò', 'ù', 'ǜ']

  def gen
    data = DataLoader.new.load
    ping = ping(data)
    ze = ze(data)
		pinyin_chars = pinyin_chars(data)

		reference = DataLoader.new.reference
		valid_chars = all_valid_chars(reference)
		valid_names = all_valid_names(reference)

    #generate(ze, ping, pinyin_chars, valid_chars, valid_names)
    zeping = []
    ze.each do |z|
      ping.each do |p|
        zeping << "#{z} #{p} #{pinyin_chars[z]} #{pinyin_chars[p]}" 
      end
    end
    zeping
  end

  def generate(ze, ping, pinyin_chars, valid_chars, valid_names)
    ze_ping = []
    ze.each do |z|
			characters = pinyin_chars[z]

			if (not z.start_with? 'n') and contain_any?(valid_chars, characters)
				ping.each do |p|
					if (not z.chr.eql?(p.chr)) and contain_any?(valid_chars, pinyin_chars[p])
						pinyin_chars[z].each do |ch_ze|
							if valid_chars.include? ch_ze
								pinyin_chars[p].each do |ch_ping|
									if valid_chars.include? ch_ping

										name = "#{ch_ze}#{ch_ping}"
										if(valid_names.include? name)
											ze_ping << "#{z} #{p} #{name}"
										end

									end
								end
							end
						end
					end
				end
			end
    end
    ze_ping
  end

	def ping(data)
		ping = Set.new
    data.each do |ch, pinyin|
      if (yin_ping? pinyin or yang_ping? pinyin)
        ping << pinyin
			end
		end
		ping
	end

	def ze(data)
		ze = Set.new
    data.each do |ch, pinyin|
      if shang_sheng? pinyin or qu_sheng? pinyin
        ze << pinyin
      end
		end
		ze
	end

	def pinyin_chars(data)
		pinyin_chars = {}
    data.each do |ch, pinyin|
			unless pinyin_chars.has_key? pinyin
				pinyin_chars[pinyin] = []
			end
			pinyin_chars[pinyin] << ch
    end
    pinyin_chars
	end

	def all_valid_chars(reference)
		valid_chars = Set.new
		reference.each_char do |ch|
			valid_chars << ch
		end
		valid_chars
	end

	def all_valid_names(reference)
		valid_names = Set.new
		prev = nil
		reference.each_char do |ch|
			if prev
				valid_names << "#{prev}#{ch}"
			end
			prev = ch
		end
		valid_names
	end

	def contain_any?(reference, chars)
		in_reference = false
		chars.each do |ch|
			if reference.include? ch
				in_reference = true
				break
			end
		end
		in_reference
	end

  def yin_ping? pinyin
    tone? pinyin, YIN_PING
  end

  def yang_ping? pinyin
    tone? pinyin, YANG_PING
  end

  def shang_sheng? pinyin
    tone? pinyin, SHANG_SHENG
  end

  def qu_sheng? pinyin
    tone? pinyin, QU_SHENG
  end

  def tone? pinyin, tone_set
    tone = false
    pinyin.each_char do |c|
      if(tone_set.include? c)
        tone = true
        break
      end
    end
    tone
  end

end
