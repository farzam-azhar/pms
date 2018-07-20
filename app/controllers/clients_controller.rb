class ClientsController < ApplicationController
  before_action :set_client, only: [:destroy, :edit, :update]
  respond_to :html, :js
  
  def index
    @clients = Client.all
  end
  
  def new
    @client = Client.new
    @msg = "Create"
    respond_with @client
  end
  
  def create
    @client = Client.new(client_params)
    if @client.save
      @check = true
    else
      @check = false
    end
    respond_with @client
  end
  
  def edit
    @msg = "Edit"
    respond_with @client
  end
  
  def update
    if @client.update_attributes(client_params)
      @check = true
    else
      @check = false
    end
    respond_with @client
  end
  
  def destroy
    if @client.destroy
      respond_with @client
    else
      redirect_to clients_path, alert: "Something went Wrong while Deleting Client"
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
