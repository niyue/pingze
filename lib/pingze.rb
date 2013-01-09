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

  TONE_MAP = Hash[
    'ā' => 'a', 'ē' => 'e', 'ī' => 'i', 'ō' => 'o', 'ū' => 'u',
    'á' => 'a', 'é' => 'e', 'í' => 'i', 'ó' => 'o', 'ú' => 'u', 'ǘ' => 'v',
    'ǎ' => 'a', 'ě' => 'e', 'ǐ' => 'i', 'ǒ' => 'o', 'ǔ' => 'u', 'ǚ' => 'v',
    'à' => 'a', 'è' => 'e', 'ì' => 'i', 'ò' => 'o', 'ù' => 'u', 'ǜ' => 'v'
  ]

  def gen
    data = DataLoader.new.load
    ping = Set.new
    ze = Set.new
    data.each do |ch, pinyin|
      if yin_ping? pinyin or yang_ping? pinyin
        ping << pinyin
      elsif shang_sheng? pinyin or qu_sheng? pinyin
        ze << pinyin
      end
    end

    ze_ping = []
    ze.each do |z|
      ping.each do |p|
        ze_ping << "#{z} #{p}"
      end
    end
    ze_ping
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
