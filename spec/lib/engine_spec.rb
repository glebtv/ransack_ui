require 'rails_helper'

RSpec.describe RansackUI::Rails::Engine do
  it 'includes ViewHelpers in ActionView::Base' do
    expect(ActionView::Base.included_modules).to include(RansackUI::ViewHelpers)
  end

  it 'includes ControllerHelpers in ActionController::Base' do
    expect(ActionController::Base.included_modules).to include(RansackUI::ControllerHelpers)
  end

  it 'is a Rails::Engine' do
    expect(described_class).to be < Rails::Engine
  end
end
