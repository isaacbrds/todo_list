require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  
  before(:each) do
    @current_member = create(:member)
    sign_in @current_member
  end
  
  context 'GET #index' do
    let(:task) { create(:task, member_id: @current_member.id) }
    
    it 'renders the index template' do
      get :index
      expect(response).to have_http_status(200)
      expect(response).to render_template('index')
    end
  end

  context 'GET #show' do
    let(:task) { create(:task) }
    it 'renders the show template' do
      get :show, params: { id: task.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template('show')
    end

    it 'renders this task' do
      get :show, params: { id: task.id }
      expect(assigns(:task)).to eq(task)
    end
  end
  context 'GET #new' do
    let(:task) { create(:task) }
    it 'renders the new template' do
      get :new
      expect(response).to have_http_status(200)
      expect(response).to render_template('new')
    end
  end

  context 'task #create' do
    let!(:params) do
      { name: 'Meu task', description: 'Meu task maroto', member_id: @current_member.id, priority: 'Baixa' }
    end

    it 'render succeful message' do
      post :create, params: { task: params }
      expect(flash[:notice]).to eq('A tarefa foi criado com sucesso')
      expect(response).to have_http_status(302)
    end
  end

  context 'GET #edit' do
    let(:task) { create(:task, member_id: @current_member.id) }
    it 'renders the edit template' do
      get :edit, params: { id: task.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template('edit')
    end
  end

  context 'PUT #update' do
    let!(:task)  do
      create(:task, member_id: @current_member.id)
    end
    it 'render succeful message' do
      params = { name: 'Meu task atualizado' }
      put :update, params: { id: task.id, task: params }
      task.reload
      expect(task.name).to eq(params[:name])
      expect(flash[:notice]).to eq('A tarefa foi atualizado com sucesso')
    end

    it 'not update a task' do  
      params = { name: nil }
      put :update, params: { id: task.id, task: params }
      expect(response).to render_template(:edit)
    end
  end

  context 'DELETE #destroy' do
    let!(:task)  do
      create(:task, member_id: @current_member.id)
    end
    it 'render succeful message' do
      delete :destroy, params: { id: task.id }
      expect(flash[:notice]).to eq('A tarefa foi destruído com sucesso')
    end
  end
end