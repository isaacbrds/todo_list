require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  before(:each) do
    @current_member = create(:member)
  end
  
  context 'GET #index' do
    let(:task) { create(:task, member_id: @current_member.id) }
    
    it 'renders the index template' do
      get :index
      expect(response).to have_http_status(302)
      expect(flash[:alert]).to eq('Para continuar, efetue login ou registre-se.')
    end
  end

  context 'GET #show' do
    let(:task) { create(:task) }
    it 'renders the show template' do
      get :show, params: { id: task.id }
      expect(response).to have_http_status(302)
      expect(flash[:alert]).to eq('Para continuar, efetue login ou registre-se.')
    end
  end
  
  context 'GET #new' do
    let(:task) { create(:task) }
    it 'renders the new template' do
      get :new
      expect(response).to have_http_status(302)
      expect(flash[:alert]).to eq('Para continuar, efetue login ou registre-se.')
    end
  end

  context 'GET #edit' do
    let(:task) { create(:task, member_id: @current_member.id) }
    it 'renders the edit template' do
      get :edit, params: { id: task.id }
      expect(response).to have_http_status(302)
      expect(flash[:alert]).to eq('Para continuar, efetue login ou registre-se.')
    end
  end

  context 'DELETE #destroy' do
    let!(:task)  do
      create(:task, member_id: @current_member.id)
    end
    it 'render succeful message' do
      delete :destroy, params: { id: task.id }
      expect(flash[:alert]).to eq('Para continuar, efetue login ou registre-se.')
    end
  end
end