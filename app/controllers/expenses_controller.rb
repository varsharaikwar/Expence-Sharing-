class ExpensesController < ApplicationController
  before_action :authenticate_user!

  def index
    @expenses = Expense.all
  end

  def show
    @expense = Expense.find(params[:id])
  end

  def new
    @group = Group.find(params[:group_id])
    @expense = @group.expenses.new
  end

  def create
    @group = Group.find(params[:group_id])
    @expense = @group.expenses.new(expense_params)
    @expense.user_id = current_user.id

    @debtors
    if expense_params[:debtor_ids].nil?
      @debtors = @group.users.reject{|user| user == current_user}
    else
      @debtors = User.find(expense_params[:debtor_ids])
    end

    if @expense.share == nil
      @expense.share = @expense.amount / (@group.users.length)
    end

    if @expense.save
      p "EXPENSE SAVED"
      @divided_cost = (@expense.amount - @expense.share)/@debtors.length
      @debtors.each do |debtor|
        debtor.debts.create(amount: @divided_cost, expense: @expense, reconciled: false)
      end
            
      redirect_to group_user_path(@group, current_user)
    else
      p "EXPENSE NOT SAVED"
      render 'new'
    end


  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    @expense = Expense.find(params[:id])
    @expense.update(expense_params)

    redirect_to group_expense_path(@expense)
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    redirect_to group_expenses_path
  end

  def chart
  @expenses_chart_data = Expense.where(date: start_date..end_date)
                                  .group(:date)
                                  .sum(:amount)
  end

  private
  def expense_params
    params.require(:expense).permit(:amount, :currency, :expense_id, :user_id, :category_id, :date, :notes, :share, :name, debtor_ids:[])
  end

  def debt_params
    params.require(:debt).permit(:amount_cents, :currency, :reconciled, :expense_id, :debtor_id)
  end
  def start_date
    Date.parse(params[:start_date]) rescue 1.month.ago.to_date
  end

  def end_date
    Date.parse(params[:end_date]) rescue Date.today
  end
end
