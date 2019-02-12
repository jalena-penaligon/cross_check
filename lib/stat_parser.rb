class StatParser
  attr_reader :merged_data
  def initialize(array_raw_data, array_merge_keys)
    @merged_data = merge_data(array_raw_data, array_merge_keys)
  end

  
end
