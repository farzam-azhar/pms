class PaymentsController < ApplicationController
  before_action :find_project
  before_action :find_payment, only: [:edit, :update, :destroy]
  respond_to :html, :js

  def new
    @payment = @project.payments.build
    respond_with @payment
  end

  def create
    @payment = @project.payments.build(payment_params)
    @payment.created_by = current_user
    @payment.save
    respond_with @payment
  end

  def edit
    respond_with @payment
  end

  def update
    @payment.update(payment_params)
    respond_with @payment
  end

  def destroy
    if @payment.destroy
      respond_with @payment
    else
      redirect_to project_path(@project), alert: "Something went Wrong while Deleting a Payment"
    end
  end

  private

    def find_project
      @project = Project.find params[:project_id]
    end

    def find_payment
      @payment = Payment.find params[:id]
    end

    def payment_params
      params.require(:payment).permit(:amount, :method)
    end
end
