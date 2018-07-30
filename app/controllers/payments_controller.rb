class PaymentsController < ApplicationController
  before_action :find_project
  before_action :find_payment, only: [:edit, :update, :destroy]
  respond_to :html, :js

  def new
    @payment = @project.payments.build
    respond_to do |format|
      format.js { render 'shared/edit', locals: { object: @payment, modal: 'payment-modal', project: @project } }
    end
  end

  def create
    @payment = @project.payments.build(payment_params)
    @payment.created_by = current_user
    @payment.save
    respond_to do |format|
      format.js {
        render 'shared/create',
        locals: {
          object: @payment,
          error_div: 'payment-error',
          modal: 'payment-modal',
          objects_div: 'payments',
          object_row: "payment-row-#{@payment.id}"
        }
      }
    end
  end

  def edit
    respond_to do |format|
      format.js { render 'shared/edit', locals: { object: @payment, modal: 'payment-modal', project: @project } }
    end
  end

  def update
    @payment.update(payment_params)
    respond_to do |format|
      format.js {
        render 'shared/update',
        locals: {
          object: @payment,
          error_div: 'payment-error',
          modal: 'payment-modal',
          object_row: "payment-row-#{@payment.id}"
        }
      }
    end
  end

  def destroy
    @payment.destroy
    respond_to do |format|
      format.js {
        render 'shared/destroy',
        locals: {
          object: @payment,
          error_div: 'payment-error',
          object_row: "payment-row-#{@payment.id}"
        }
      }
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
