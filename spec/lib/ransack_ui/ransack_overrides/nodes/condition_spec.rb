require 'rails_helper'

RSpec.describe 'Ransack::Nodes::Condition override' do
  describe '#default? and #is_default=' do
    it 'is set to true for conditions built via new_condition' do
      search = Article.ransack
      grouping = search.build_grouping
      condition = grouping.new_condition
      expect(condition.default?).to eq(true)
    end

    it 'can be set to true explicitly' do
      search = Article.ransack
      condition = search.build_condition
      condition.is_default = true
      expect(condition.default?).to eq(true)
    end

    it 'can be set to false' do
      search = Article.ransack
      condition = search.build_condition
      condition.is_default = false
      expect(condition.default?).to eq(false)
    end
  end
end
