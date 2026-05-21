require 'rails_helper'

RSpec.describe RansackUI::ControllerHelpers, type: :controller do
  controller(ActionController::Base) do
    def index
      load_ransack_search(Article)
      render plain: 'ok'
    end

    def custom
      load_ransack_search(Account)
      render plain: 'ok'
    end
  end

  before do
    @routes.draw do
      get 'index' => 'anonymous#index'
      get 'custom' => 'anonymous#custom'
    end
  end

  describe '#load_ransack_search' do
    it 'builds @ransack_search from params[:q]' do
      account = Account.create!(name: 'Test Account', email: 'test@example.com')
      Article.create!(title: 'Test Article', account: account)

      get :index, params: { q: { title_eq: 'Test Article' } }
      expect(assigns(:ransack_search)).to be_a(Ransack::Search)
    end

    it 'builds a grouping when groupings are empty' do
      get :index
      search = assigns(:ransack_search)
      expect(search.groupings).not_to be_empty
    end

    it 'returns the search object' do
      get :index
      expect(assigns(:ransack_search)).to be_a(Ransack::Search)
    end

    it 'uses the provided class argument' do
      get :custom
      search = assigns(:ransack_search)
      expect(search.klass).to eq(Account)
    end
  end
end
