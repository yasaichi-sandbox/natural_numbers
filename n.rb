# frozen_string_literal: true

require 'forwardable'
require 'set'

# NOTE: Implements a set of natural numbers that satisfies Peano axioms
# by John von Neumann's construction
class N
  extend Forwardable

  attr_reader :set
  def_delegator :@set, :hash
  def_delegator :@set, :empty?, :zero?

  private_class_method :new
  protected :set, :zero?

  def initialize(set)
    @set = set.dup.freeze
  end

  def self.zero
    @zero ||= new(Set[])
  end

  # NOTE: We can't use `Comparable` module because we need to use an integer
  # in the implementation of `<=>` although we're trying to implement a set
  # of natural numbers.
  def ==(other)
    less, greater = compare(other)
    !less && !greater
  end
  alias eql? ==

  def <(other)
    less, = compare(other)
    less
  end

  def <=(other)
    less, greater = compare(other)
    less || !greater
  end

  def >(other)
    _, greater = compare(other)
    greater
  end

  def >=(other)
    less, greater = compare(other)
    greater || !less
  end

  def +(other)
    other.zero? ? self : (self + other.pre).suc
  end

  def suc
    @suc ||= self.class.__send__(:new, @set | Set[@set])
  end

  protected def pre
    raise "a predecessor of zero doesn't exist" if zero?

    @pre ||= self.class.__send__(
      :new,
      @set.find { |nested_set| nested_set == @set - Set[nested_set] }
    )
  end

  private def compare(other)
    unless other.is_a?(self.class)
      raise ArgumentError, "comparison of #{self.class} with #{other.inspect} failed"
    end

    [@set.proper_subset?(other.set), @set.proper_superset?(other.set)]
  end
end
