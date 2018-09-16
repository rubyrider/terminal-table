require 'spec_helper'
require "db-table/import"

describe Object do
  describe "#table" do
    it "should allow creation of a terminal table" do
      table(['foo', 'bar'], ['a', 'b'], [1, 2]).should be_instance_of(DB::Table)
    end
  end
end
