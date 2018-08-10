class ProjectPdf < Prawn::Document
  require "prawn/table"

  def initialize(project, view_context)
    super(top_margin: 50)
    @project = project
    @view = view_context
    project_title
    project_attributes
    project_payments
    project_assigned_users
  end

  def project_title
    text @project.title, size: 30, style: :bold
  end

  def project_attributes
    move_down 20
    text "Estimated Price: #{ @project.estimated_price }"
    text "Time Frame: #{ @view.time_ago_in_words(@project.end_date).capitalize }"
    text "Client: #{@project.client.name.capitalize}"
    text "Started At: #{@project.created_at.strftime("%m-%d-%Y")}"
    move_down 15
    text "Description", size: 20, style: :bold
    move_up 15
    text "#{@view.sanitize(@project.description, tags: {})}"
  end

  def project_payments
    move_down 20
    text 'Payments', size: 20, style: :bold
    move_down 10
    table project_payment_rows do
      row(0).font_style = :bold
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
      self.cells.padding = 10
    end
    move_down 15
    text "Total Payment $#{@project.payments.sum(:amount)}", size: 15, style: :bold
  end

  def project_payment_rows
    payment_array = []
    payment_array << %w[amount created_by method created_at].map(&:humanize)

    @project.payments.includes(:created_by).map do |payment|
      payment_array << [
        "$#{payment.amount}",
        payment.creator,
        payment.method,
        payment.created_at.strftime("%m-%d-%Y")
      ]
    end
    payment_array
  end

  def project_assigned_users
    move_down 25
    text 'Assigned Users', size: 20, style: :bold
    move_down 10
    table project_assigned_users_rows do
      row(0).font_style = :bold
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
      self.cells.padding = 10
    end
  end

  def project_assigned_users_rows
    assigned_users_array = []
    assigned_users_array << %w[Username Role]

    @project.assignments.includes(:user).map do |user|
      assigned_users_array << [
        user.user.username,
        user.role.humanize
      ]
    end
    assigned_users_array
  end
end
