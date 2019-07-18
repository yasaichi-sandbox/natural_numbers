# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/spec'
require_relative 'n'

describe N do
  before do
    @zero = N.zero
    @one = @zero.suc
    @two = @one.suc
    @three = @two.suc
  end

  describe '#==' do
    it 'should return true when a reciver is equal to an argument' do
      assert @zero == @zero
    end

    it "should return false when a reciver isn't equal to an argument" do
      assert_equal false, @zero == @one
    end
  end

  describe '#<' do
    it 'should return true when a reciver is less than an argument' do
      assert @zero < @one
    end

    it 'should return false when a reciver is greater than or equal to an argument' do
      assert_equal false, @zero < @zero
      assert_equal false, @one < @zero
    end
  end

  describe '#>' do
    it 'should return true when a reciver is greater than an argument' do
      assert @one > @zero
    end

    it 'should return false when a reciver is less than or equal to an argument' do
      assert_equal false, @zero > @zero
      assert_equal false, @zero > @one
    end
  end

  describe '#+' do
    it 'should return 1 for 1 + 0' do
      assert_equal @one, @one + @zero
    end

    it 'should return 2 for 1 + 1' do
      assert_equal @two, @one + @one
    end

    it 'should return 3 for 1 + 2' do
      assert_equal @three, @one + @two
    end
  end
end
