require 'rails_helper'

RSpec.describe 'Ransack::Configuration overrides' do
  describe '#default_predicates=' do
    it 'sets default predicate options' do
      Ransack.configure do |config|
        config.default_predicates = { only: %i[eq cont] }
      end
      expect(Ransack.options[:default_predicates]).to eq({ only: %i[eq cont] })
    end
  end

  describe '#ajax_options=' do
    it 'sets ajax options' do
      Ransack.configure do |config|
        config.ajax_options = { url: '/search.json', type: 'GET' }
      end
      expect(Ransack.options[:ajax_options]).to eq({ url: '/search.json', type: 'GET' })
    end
  end
end
