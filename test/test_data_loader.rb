#!/bin/env ruby
# encoding: utf-8

require "minitest/autorun"
require "data_loader"

class TestDataLoader < MiniTest::Unit::TestCase
  def test_load
    data = DataLoader.new.load
    assert data.length > 0
    assert data.keys.length > 0
  end

	def test_load_reference
    reference = DataLoader.new.reference
    assert reference.length > 0
	end
end
