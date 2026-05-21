require 'rails_helper'

RSpec.describe RansackUI do
  it 'has a version number' do
    expect(RansackUI::VERSION).to eq('3.0.0')
  end

  it 'version is frozen' do
    expect(RansackUI::VERSION).to be_frozen
  end
end
