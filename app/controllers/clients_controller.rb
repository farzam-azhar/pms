
class ClientsController < ApplicationController
  before_action :set_client, only: [:destroy, :edit, :update, :update_status]
  respond_to :html, :js
  
  def index
    @clients = Client.all
  end
  
  def new
    @client = Client.new
    respond_to do |format|
      format.js { render 'shared/edit', locals: { object: @client, modal: 'client-modal', project: nil } }
    end
  end
  
  def create
    @client = Client.create(client_params)
    respond_to do |format|
      format.js {
        render 'shared/create',
        locals: {
          object: @client,
          error_div: 'client_error',
          modal: 'client-modal',
          objects_div: 'clients',
          object_row: "client-#{@client.id}"
        }
      }
    end
  end
  
  def edit
    respond_to do |format|
      format.js { render 'shared/edit', locals: { object: @client, modal: 'client-modal', project: nil } }
    end
  end
  
  def update
    @client.update_attributes(client_params)
    respond_to do |format|
      format.js {
        render 'shared/update',
        locals: {
          object: @client,
          error_div: 'client_error',
          modal: 'client-modal',
          object_row: "client-#{@client.id}"
        }
      }
    end
  end
  
  def update_status
    @client.toggle_status!
    respond_to do |format|
      format.js {
        render 'shared/destroy',
        locals: {
          object: @client,
          error_div: 'client-error',
          object_row: "client-#{@client.id}"
        }
      }
    end
  end
  
  private

    def client_params
      params.require(:client).permit(:name, :email, :country_code)
    end
    
    def set_client
      @client = Client.find params[:id]
    end
end
