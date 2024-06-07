import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    
  }
  
  async getById(id){
    const response = await fetch(`http://localhost:3000/tasks/${id}.json`);
    const taskData = await response.json();
    return taskData;  
  }

  resetCard(){
    document.getElementById('show-description').innerHTML = "";
  }

  createCard(headerText, titleText, bodyText, buttonTextEdit, buttonLinkEdit, buttonTextDelete, buttonLinkDelete, formText ){
    const cardContainer = document.getElementById('show-description');
         // Cria os elementos do card
    const card = document.createElement('div');
    card.className = 'card';

    const cardHeader = document.createElement('div');
    cardHeader.className = 'card-header';
    cardHeader.textContent = headerText;

    const cardBody = document.createElement('div');
    cardBody.className = 'card-body';

    const cardTitle = document.createElement('h5');
    cardTitle.className = 'card-title';
    cardTitle.textContent = titleText;

    const cardText = document.createElement('p');
    cardText.className = 'card-text';
    cardText.textContent = bodyText;

    const cardFormText =  formText;
    
    

    const cardButtonEdit = document.createElement('a');
    cardButtonEdit.className = 'p-3';
    cardButtonEdit.href = buttonLinkEdit;
    cardButtonEdit.textContent = buttonTextEdit;

    const cardButtonDelete = document.createElement('a');
    cardButtonDelete.className = 'p-3';
    cardButtonDelete.setAttribute('data-turbo-method', 'delete');
    cardButtonDelete.href = buttonLinkDelete;
    cardButtonDelete.textContent = buttonTextDelete;

    // Adiciona os elementos ao cardBody
    cardBody.appendChild(cardTitle);
    cardBody.appendChild(cardText);
    cardBody.appendChild(cardFormText);
    cardBody.appendChild(cardButtonEdit);
    cardBody.appendChild(cardButtonDelete);

    // Adiciona o cardHeader e o cardBody ao card
    card.appendChild(cardHeader);
    card.appendChild(cardBody);

    // Adiciona o card ao contêiner
    cardContainer.appendChild(card);   
   
  }

  async show(){
    this.resetCard();
    event.preventDefault();
    const currentMember = document.getElementById('current_member').innerText;
    const task = await this.getById(event.currentTarget.dataset.task)
    const authenticity_token = document.querySelector("meta[name=csrf-token]").getAttribute('content')
    
    if(currentMember == task.member_id){
      const form = this.createForm(task, authenticity_token)
      this.createCard(task.name, ' ',task.description, 'Editar', `http://localhost:3000/tasks/${parseInt(task.id)}/edit`, 'Deletar', `http://localhost:3000/tasks/${parseInt(task.id)}`, form);
    }else{
      const form = document.createElement('form');
      this.createCard(task.name, ' ',task.description, '', null, '', null, form);
    }
  }

  
  createForm(task, csrfToken){
    const form = document.createElement('form');
    // Cria o campo oculto (hidden input)
    const titleDiv = document.createElement('div');
    titleDiv.className = 'mb-3';
    const titleLabel = document.createElement('label');
    titleLabel.className = 'form-label px-3';
    titleLabel.for = 'task-title';
    titleLabel.textContent = 'Finalizado?';
    const titleInput = document.createElement('input');
    titleInput.className = 'form-checkbox';
    titleInput.type = 'checkbox';
    titleInput.id = 'task_completed';
    titleInput.checked = task.completed;
    if(task.completed){
      titleInput.setAttribute('disabled', 'disabled');
    }
    titleDiv.appendChild(titleLabel);
    titleDiv.appendChild(titleInput);
    const submitButton = document.createElement('button');
    submitButton.type = 'submit';
    submitButton.className = 'btn btn-primary mb-3';
    submitButton.textContent = 'Atualizar';
    form.appendChild(titleDiv);
    form.appendChild(submitButton);
    form.addEventListener('submit', async function(event){
      event.preventDefault();
      task.completed = titleInput.checked;
      const payload = {
        task: task,
        authenticity_token: csrfToken
    }

    const requestOptions = {
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(payload)
    }
      requestOptions.method = "PUT"
      const url = `http://localhost:3000/tasks/${task.id}.json`;
    
      const data = await (await fetch(url, requestOptions)).json();
      setTimeout(function() {
      
        window.location.reload();
      }, 1000);
    })

    
    return form;
  }
}
