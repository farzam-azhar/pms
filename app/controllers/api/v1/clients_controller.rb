class Api::V1::ClientsController < ApiController
  before_action :authorize_managerial_rights, only: [:create, :update]
  before_action :find_client, only: [:show, :update]

  def index
    @clients = Client.all
    render json: @clients
  end

  def show
    render json: @client, include: ['projects']
  end

  def create
    @client = Client.create(client_params)
    if @client.persisted?
      render json: @client, status: :ok
    else
      render json: @client.errors, status: :bad_request
    end
  end

  def update
    if @client.update(client_params)
      render json: @client, status: :ok
    else
      render json: @client.errors, status: :bad_request
    end
  end

  private

    def find_client
      @client = Client.find params[:id]
    end

    def client_params
      params.require(:client).permit(:name, :country_code, :email)
    end

    def authorize_managerial_rights
      render json: {}, status: 401 unless @current_user.has_managerial_rights?
    end

    def auth_token
      @auth_token ||= request.headers.fetch("Authorization", "").split(' ').last
    end
end
