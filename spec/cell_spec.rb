require 'spec_helper'

describe DB::Table do
  Cell = DB::Table::Cell

  it "should default alignment to the left" do
    cell = Cell.new :value => 'foo', :table => DB::Table.new, :index => 0
    cell.value.should eq 'foo'
    cell.alignment.should eq :left
  end

  it "should allow overriding of alignment" do
    cell = Cell.new :value => 'foo', :alignment => :center, :table => DB::Table.new, :index => 0
    cell.value.should eq 'foo'
    cell.alignment.should eq :center
  end

  it "should allow :left, :right and :center for alignment" do
    @cell = Cell.new :value => 'foo', :table => DB::Table.new, :index => 0
    @cell.alignment = :left
    @cell.alignment = :right
    @cell.alignment = :center
    lambda { @cell.alignment = "foo" }.should raise_error(RuntimeError)
  end

  it "should allow multiline content" do
    cell = Cell.new :value => "barrissimo\n"+"foo".yellow, :table => DB::Table.new, :index => 0
    cell.value.should eq "barrissimo\n"+"foo".yellow
    cell.lines.should eq ['barrissimo','foo'.yellow]
    cell.value_for_column_width_recalc.should eq 'barrissimo'
    cell.render(0).should eq " barrissimo "
  end

  it "should allow colorized content" do
    cell = Cell.new :value => "foo".red, :table => DB::Table.new, :index => 0
    cell.value.should eq "\e[31mfoo\e[0m"
    cell.value_for_column_width_recalc.should eq 'foo'
    cell.render.should eq " \e[31mfoo\e[0m "
  end

  it "should render padding properly" do
    @table = DB::Table.new(:rows => [['foo', '2'], ['3', '4']], :style => {:padding_right => 3})
    cell = @table.rows.first.cells.first
    cell.value.should eq 'foo'
    cell.alignment.should eq :left
    cell.render.should eq " foo   "
  end

  it "should not ignore pipe characters" do
    cell = Cell.new :value => "f|o|o", :table => DB::Table.new, :index => 0
    cell.value.should eq "f|o|o"
    cell.value_for_column_width_recalc.should eq 'f|o|o'
    cell.render.should eq " f|o|o "
  end
end
