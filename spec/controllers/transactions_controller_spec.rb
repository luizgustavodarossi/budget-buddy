require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  describe "GET #index" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      let!(:transactions) { create_list :transaction, 3, user: current_user }
      before { sign_in current_user }

      it "returns http success" do
        get :index
        expect(response).to have_http_status :success
      end

      it "returns only the current user's transaction" do
        another_user = create :user
        another_transaction = create :transaction, user: another_user

        get :index
        expect(assigns(:transactions)).to match_array transactions
        expect(assigns(:transactions)).not_to include another_transaction
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    context "when user is not logged in" do
      let!(:transactions) { create_list :transaction, 3 }

      it "returns http redirect" do
        get :index
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "GET #show" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      let(:transaction) { create :transaction, user: current_user }
      before { sign_in current_user }

      it "returns http success" do
        get :show, params: { id: transaction.id }
        expect(response).to have_http_status :success
      end

      it "returns only the current user's transaction" do
        another_user = create :user
        another_transaction = create :transaction, user: another_user

        get :show, params: { id: transaction.id }
        expect(assigns(:transaction)).to eq transaction

        expect do
          get :show, params: { id: another_transaction.id }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "renders the show template" do
        get :show, params: { id: transaction.id }
        expect(response).to render_template :show
      end
    end

    context "when user is not logged in" do
      let(:transaction) { create :transaction }

      it "returns http redirect" do
        get :show, params: { id: transaction.id }
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "GET #new" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      before { sign_in current_user }

      it "returns http success" do
        get :new
        expect(response).to have_http_status :success
      end

      it "returns a new transaction created by the current user" do
        get :new
        expect(assigns(:transaction)).to be_a_new(Transaction)
        expect(assigns(:transaction).user).to eq current_user
      end

      it "renders the new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    context "when user is not logged in" do
      it "returns http redirect" do
        get :new
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "GET #edit" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      let(:transaction) { create :transaction, user: current_user }
      before { sign_in current_user }

      it "returns http success" do
        get :edit, params: { id: transaction.id }
        expect(response).to have_http_status :success
      end

      it "returns only the current user's transaction" do
        another_user = create :user
        another_transaction = create :transaction, user: another_user

        get :edit, params: { id: transaction.id }
        expect(assigns(:transaction)).to eq transaction

        expect do
          get :edit, params: { id: another_transaction.id }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "renders the edit template" do
        get :edit, params: { id: transaction.id }
        expect(response).to render_template :edit
      end
    end

    context "when user is not logged in" do
      let(:transaction) { create :transaction }

      it "returns http redirect" do
        get :edit, params: { id: transaction.id }
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "POST #create" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      before { sign_in current_user }

      context "with valid params" do
        let(:user) { create :user }
        let(:category) { create :category }
        let(:account) { create :account }
        let(:valid_params) do
          attributes_for :transaction,
                         user: user, category_id: category.id,
                         accountable_id: account.id, accountable_type: "Account"
        end

        it "creates a new transaction for the current user" do
          expect do
            post :create, params: { transaction: valid_params }
          end.to change(current_user.transactions, :count).by 1
        end

        it "redirects to the created transaction" do
          post :create, params: { transaction: valid_params }
          expect(response).to redirect_to transaction_path(Transaction.last)
        end
      end

      context "with invalid params" do
        let(:user) { create :user }
        let(:category) { create :category }
        let(:account) { create :account }
        let(:invalid_params) do
          attributes_for :transaction, amount: nil,
                                       user: user, category_id: category.id,
                                       accountable_id: account.id, accountable_type: "Account"
        end

        it "does not create a new transaction" do
          expect do
            post :create, params: { transaction: invalid_params }
          end.to change(Transaction, :count).by(0)
        end

        it "renders the new template" do
          post :create, params: { transaction: invalid_params }
          expect(response).to render_template :new
        end
      end
    end

    context "when user is not logged in" do
      let(:valid_params) { attributes_for :transaction }

      it "returns http redirect" do
        post :create, params: { transaction: valid_params }
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "PATCH #update" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      let(:transaction) { create :transaction, user: current_user }
      before { sign_in current_user }

      context "with valid params" do
        let(:valid_params) { attributes_for :transaction, amount: 100 }

        it "updates the transaction" do
          patch :update, params: { id: transaction.id, transaction: valid_params }
          transaction.reload
          expect(transaction.amount).to eq 100
        end

        it "redirects to the updated transaction" do
          patch :update, params: { id: transaction.id, transaction: valid_params }
          expect(response).to redirect_to transaction_path(transaction)
        end
      end

      context "with invalid params" do
        let(:invalid_params) { attributes_for :transaction, amount: nil }

        it "does not update the transaction" do
          patch :update, params: { id: transaction.id, transaction: invalid_params }
          transaction.reload
          expect(transaction.amount).not_to be_nil
        end

        it "renders the edit template" do
          patch :update, params: { id: transaction.id, transaction: invalid_params }
          expect(response).to render_template :edit
        end
      end
    end

    context "when user is not logged in" do
      let(:transaction) { create :transaction }
      let(:valid_params) { attributes_for :transaction, amount: 100 }

      it "returns http redirect" do
        patch :update, params: { id: 1, transaction: valid_params }
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "DELETE #destroy" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      let!(:transaction) { create :transaction, user: current_user }
      before { sign_in current_user }

      it "destroys the transaction" do
        expect do
          delete :destroy, params: { id: transaction.id }
        end.to change(Transaction, :count).by(-1)
      end

      it "redirects to the transactions index" do
        delete :destroy, params: { id: transaction.id }
        expect(response).to redirect_to transactions_path
      end
    end

    context "when user is not logged in" do
      let!(:transaction) { create :transaction }

      it "returns http redirect" do
        delete :destroy, params: { id: transaction.id }
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
