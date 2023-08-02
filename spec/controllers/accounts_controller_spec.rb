require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  describe "GET #index" do  
    context "when user is logged in" do
      let(:current_user) { create :user }
      let!(:accounts) { create_list :account, 3, user: current_user }
      before { sign_in current_user }
      
      it "returns http success" do
        get :index
        expect(response).to have_http_status :success
      end

      it "returns only the current user's accounts" do
        another_user = create :user
        another_account = create :account, user: another_user

        get :index
        expect(assigns(:accounts)).to match_array accounts
        expect(assigns(:accounts)).not_to include another_account
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    context "when user is not logged in" do
      let!(:accounts) { create_list :account, 3 }

      it "returns http redirect" do
        get :index
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "GET #show" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      let(:account) { create :account, user: current_user }
      before { sign_in current_user }

      it "returns http success" do
        get :show, params: { id: account.id }
        expect(response).to have_http_status :success
      end

      it "returns only the current user's account" do
        another_user = create :user
        another_account = create :account, user: another_user

        get :show, params: { id: account.id }
        expect(assigns(:account)).to eq account

        expect { 
          get :show, params: { id: another_account.id }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "renders the show template" do
        get :show, params: { id: account.id }
        expect(response).to render_template :show
      end
    end

    context "when user is not logged in" do
      let(:account) { create :account }

      it "returns http redirect" do
        get :show, params: { id: account.id }
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

      it "returns a new account created by the current user" do
        get :new
        expect(assigns(:account)).to be_a_new(Account)
        expect(assigns(:account).user).to eq current_user
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
      let(:account) { create :account, user: current_user }
      before { sign_in current_user }

      it "returns http success" do
        get :edit, params: { id: account.id }
        expect(response).to have_http_status :success
      end

      it "returns only the current user's account" do
        another_user = create :user
        another_account = create :account, user: another_user

        get :edit, params: { id: account.id }
        expect(assigns(:account)).to eq account

        expect { 
          get :edit, params: { id: another_account.id }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "renders the edit template" do
        get :edit, params: { id: account.id }
        expect(response).to render_template :edit
      end
    end

    context "when user is not logged in" do
      let(:account) { create :account }

      it "returns http redirect" do
        get :edit, params: { id: account.id }
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "POST #create" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      before { sign_in current_user }

      context "with valid params" do
        let(:valid_params) { attributes_for :account }

        it "creates a new account for the current user" do
          expect {
            post :create, params: { account: valid_params }
          }.to change(current_user.accounts, :count).by(1)
        end

        it "redirects to the created account" do
          post :create, params: { account: valid_params }
          expect(response).to redirect_to account_path(Account.last)
        end
      end

      context "with invalid params" do
        let(:invalid_params) { attributes_for :account, name: nil }

        it "does not create a new account" do
          expect {
            post :create, params: { account: invalid_params }
          }.to change(Account, :count).by(0)
        end

        it "renders the new template" do
          post :create, params: { account: invalid_params }
          expect(response).to render_template :new
        end
      end
    end

    context "when user is not logged in" do
      let(:valid_params) { attributes_for :account }

      it "returns http redirect" do
        post :create, params: { account: valid_params }
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "PATCH #update" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      let(:account) { create :account, user: current_user }
      before { sign_in current_user }

      context "with valid params" do
        let(:valid_params) { attributes_for :account, name: "Updated Name" }

        it "updates the requested account" do
          patch :update, params: { id: account.id, account: valid_params }
          account.reload
          expect(account.name).to eq "Updated Name"
        end

        it "redirects to the account" do
          patch :update, params: { id: account.id, account: valid_params }
          expect(response).to redirect_to account_path(account)
        end
      end

      context "with invalid params" do
        let(:invalid_params) { attributes_for :account, name: nil }

        it "does not update the requested account" do
          patch :update, params: { id: account.id, account: invalid_params }
          account.reload
          expect(account.name).not_to be_nil
        end

        it "renders the edit template" do
          patch :update, params: { id: account.id, account: invalid_params }
          expect(response).to render_template :edit
        end
      end
    end

    context "when user is not logged in" do
      let(:account) { create :account }
      let(:valid_params) { attributes_for :account, name: "Updated Name" }

      it "returns http redirect" do
        patch :update, params: { id: account.id, account: valid_params }
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "DELETE #destroy" do
    context "when user is logged in" do
      let(:current_user) { create :user }
      let!(:account) { create :account, user: current_user }
      before { sign_in current_user }

      it "destroys the requested account" do
        expect {
          delete :destroy, params: { id: account.id }
        }.to change(Account, :count).by(-1)
      end

      it "redirects to the accounts list" do
        delete :destroy, params: { id: account.id }
        expect(response).to redirect_to accounts_path
      end
    end

    context "when user is not logged in" do
      let!(:account) { create :account }

      it "returns http redirect" do
        delete :destroy, params: { id: account.id }
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end