require 'rails_helper'

RSpec.describe RansackUI::ViewHelpers, type: :helper do
  describe '#ransack_ui_search' do
    it 'renders the ransack_ui/search partial' do
      expect(helper).to receive(:render).with('ransack_ui/search', options: {})
      helper.ransack_ui_search
    end

    it 'passes options to the partial' do
      opts = { theme: :bootstrap }
      expect(helper).to receive(:render).with('ransack_ui/search', options: opts)
      helper.ransack_ui_search(opts)
    end
  end

  describe '#link_to_remove_fields' do
    let(:search) { Article.ransack }
    let(:builder) do
      ActionView::Helpers::FormBuilder.new(:q, search, helper, {})
    end

    it 'generates a remove fields link for bootstrap theme' do
      allow(helper).to receive(:link_to).and_return('<a class="remove_fields btn btn-mini btn-danger">x</a>'.html_safe)
      link = helper.link_to_remove_fields('Remove', builder, { theme: :bootstrap })
      expect(helper).to have_received(:link_to).with(
        '<i class="icon-remove icon-white"></i>',
        nil,
        class: 'remove_fields btn btn-mini btn-danger'
      )
      expect(link).to include('remove_fields')
    end

    it 'generates a remove fields link for default theme' do
      allow(helper).to receive(:image_tag).and_return('<img src="delete.png">'.html_safe)
      allow(helper).to receive(:link_to).and_return('<a class="remove_fields"><img></a>'.html_safe)
      link = helper.link_to_remove_fields('Remove', builder, {})
      expect(helper).to have_received(:image_tag).with(
        'ransack_ui/delete.png', size: '16x16', alt: 'Remove'
      )
      expect(helper).to have_received(:link_to).with(
        '<img src="delete.png">'.html_safe,
        nil,
        class: 'remove_fields'
      )
      expect(link).to include('remove_fields')
    end
  end

  describe '#link_to_add_fields' do
    let(:search) { Article.ransack }
    let(:builder) { double('FormBuilder') }
    let(:new_object) { double('new_grouping') }

    it 'builds new object and generates link with data attributes' do
      allow(builder).to receive(:object).and_return(search)
      allow(search).to receive(:build_grouping).and_return(new_object)
      allow(builder).to receive(:grouping_fields).with(new_object, child_index: 'new_grouping').and_yield(builder)
      allow(helper).to receive(:render).and_return('fields html')
      allow(helper).to receive(:link_to).and_return(
        '<a class="add_fields" data-field-type="grouping">Add</a>'.html_safe
      )

      link = helper.link_to_add_fields('Add', builder, :grouping, {})
      expect(search).to have_received(:build_grouping)
      expect(helper).to have_received(:link_to).with(
        'Add', nil,
        hash_including(class: 'add_fields', 'data-field-type' => :grouping)
      )
      expect(link).to include('add_fields')
    end

    it 'uses bootstrap theme classes when specified' do
      allow(builder).to receive(:object).and_return(search)
      allow(search).to receive(:build_grouping).and_return(new_object)
      allow(builder).to receive(:grouping_fields).with(new_object, child_index: 'new_grouping').and_yield(builder)
      allow(helper).to receive(:render).and_return('fields html')
      allow(helper).to receive(:link_to).and_yield.and_return(
        '<a class="add_fields btn btn-small btn-primary">Add</a>'.html_safe
      )

      helper.link_to_add_fields('Add', builder, :grouping, { theme: :bootstrap })
      expect(helper).to have_received(:link_to).with(
        nil,
        hash_including(
          class: 'add_fields btn btn-small btn-primary',
          'data-field-type' => :grouping
        )
      )
    end
  end
end
