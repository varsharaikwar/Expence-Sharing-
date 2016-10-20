class DebtsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @debts = @user.debts.all

    @ious = Debt.all.select do |debt|
      if debt.reconciled == false
        debt.expense.user == @user
      end
    end
  end

  def settle

  end

  # def show
  #   @debt = Debt.find(params[:id])
  # end
  #
  # def new
  #   # @user = User.find(params[:user_id])
  #   # @debt = @user.debt.new
  # end
  #
  # def create
  #   # @user = User.find(params[:user_id])
  #   # @debt = @user.debt.create(debt_params)
  # end
  #
  # def edit
  #   # @debt = Debt.find(params[:id])
  # end
  #
  # def update
  #   # @debt = Debt.find(params[:id])
  #   # @debt.update(debt_params)
  #   #
  #   # redirect_to debt_path(@debt)
  # end
  #
  def destroy
    @group = Group.find(params[:group_id])
    @user = User.find(params[:user_id])
    @other_user = User.find(params[:other_user])
    @user.owed(@group, @other_user).each do |debt|
      debt.update(reconciled: true);
    end
    @other_user.owed(@group, @user).each do |debt|
      debt.update(reconciled: true);
    end

    redirect_to group_user_path(@group, @user)
  end

  # strong params
  private
  def debt_params
    params.require(:debt).permit(:amount, :reconciled, :expense_id, :debtor_id)
  end
end
