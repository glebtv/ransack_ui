require 'rails_helper'

RSpec.describe RansackUI::Adapters::ActiveRecord::Base do
  describe '.has_ransackable_associations' do
    it 'sets the ransackable associations on the model' do
      Article.has_ransackable_associations %w[account tags]
      expect(Article._ransackable_associations).to eq(%w[account tags])
    end
  end

  describe '.ransack_can_autocomplete' do
    it 'enables autocomplete on the model' do
      Article.ransack_can_autocomplete
      expect(Article._ransack_can_autocomplete).to eq(true)
    end
  end

  describe '.ransackable_attributes' do
    it 'returns array of [name, type] pairs for columns' do
      attrs = Article.ransackable_attributes
      expect(attrs).to include(['title', :string])
      expect(attrs).to include(['body', :text])
      expect(attrs).to include(['published', :boolean])
    end

    it 'includes column names and types' do
      attrs = Article.ransackable_attributes
      col_names = attrs.map(&:first)
      expect(col_names).to include('id', 'title', 'body', 'published', 'account_id', 'created_at', 'updated_at')
    end
  end

  describe '.ransackable_associations' do
    it 'returns only declared associations when configured' do
      Article.has_ransackable_associations %w[account tags]
      associations = Article.ransackable_associations
      expect(associations).to include('account', 'tags')
    end

    it 'returns all associations when none declared' do
      original = Article._ransackable_associations
      Article._ransackable_associations = []
      associations = Article.ransackable_associations
      expect(associations).to include('account', 'tags')
      Article._ransackable_associations = original
    end

    it 'filters associations to only valid ones' do
      Article.has_ransackable_associations %w[account tags nonexistent]
      associations = Article.ransackable_associations
      expect(associations).not_to include('nonexistent')
    end
  end

  describe '.ransortable_attributes' do
    it 'returns attribute names from ransackable_attributes' do
      attrs = Article.ransortable_attributes
      expect(attrs).to include('title', 'body')
    end
  end

  describe 'default values' do
    it '_ransackable_associations defaults to empty array' do
      expect(Account._ransackable_associations).to eq([])
    end

    it '_ransack_can_autocomplete defaults to false' do
      Tag._ransack_can_autocomplete = false
      expect(Tag._ransack_can_autocomplete).to eq(false)
    end
  end
end
