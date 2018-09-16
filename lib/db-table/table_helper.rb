module DB
  class Table
    module TableHelper
      def table headings = [], *rows, &block
        DB::Table.new :headings => headings.to_a, :rows => rows, &block
      end
    end
  end
end
