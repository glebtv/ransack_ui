require 'rails_helper'

RSpec.describe 'Ransack::Nodes::Grouping override' do
  describe '#new_condition' do
    it 'creates a new condition with default predicate eq' do
      search = Article.ransack
      grouping = search.build_grouping
      condition = grouping.new_condition
      expect(condition.predicate_name).to eq('eq')
    end

    it 'marks the condition as default' do
      search = Article.ransack
      grouping = search.build_grouping
      condition = grouping.new_condition
      expect(condition.default?).to eq(true)
    end

    it 'builds one attribute by default' do
      search = Article.ransack
      grouping = search.build_grouping
      condition = grouping.new_condition
      expect(condition.attributes.size).to eq(1)
    end

    it 'builds one value by default' do
      search = Article.ransack
      grouping = search.build_grouping
      condition = grouping.new_condition
      expect(condition.values.size).to eq(1)
    end

    it 'accepts custom predicate' do
      search = Article.ransack
      grouping = search.build_grouping
      condition = grouping.new_condition(predicate: 'cont')
      expect(condition.predicate_name).to eq('cont')
    end
  end
end
