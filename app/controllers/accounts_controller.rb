class AccountsController < ApplicationController
  include Pagy::Backend
  before_action :set_account, only: %i[ show edit update destroy ]

  def index
    @accounts = current_user.accounts
    @accounts = @accounts.search(params[:search]) if params[:search].present?

    @pagy, @accounts = pagy(@accounts)
  end

  def show
  end

  def new
    @account = current_user.accounts.new
  end

  def edit
  end

  def create
    @account = current_user.accounts.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to account_url(@account), notice: "Account was successfully created." }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to account_url(@account), notice: "Account was successfully updated." }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url, notice: "Account was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_account
      @account = current_user.accounts.find(params[:id])
    end

    def account_params
      params.require(:account).permit(:name, :kind, :balance)
    end
end
