describe WebhooksController do
  let(:user) { users(:jami) }
  before do
    allow_any_instance_of(WebhooksController).to receive(:current_user) { user }
  end

  let(:base_params) { { } }

  describe '#index' do
    let!(:user_webhooks) do
      [
        Metova::Webhook.create(event: "post:create", url: 'https://google.com', user: user),
        Metova::Webhook.create(event: "post:create", url: 'https://google.com', user: user)
      ]
    end

    let!(:other_webhooks) do
      [
        Metova::Webhook.create(event: "post:create", url: 'https://google.com', user: users(:logan)),
        Metova::Webhook.create(event: "post:create", url: 'https://google.com', user: users(:logan))
      ]
    end

    it 'should list the users webhooks' do
      get :index, base_params
      user_webhooks.each do |webhook|
        expect(response.body).to include webhook.to_json
      end
    end

    it 'should not list other users webhooks' do
      get :index, base_params
      other_webhooks.each do |webhook|
        expect(response.body).to_not include webhook.to_json
      end
    end
  end

  describe '#create' do
    describe 'with valid params' do
      before do
        base_params.merge! webhook: { event: "post:create", url: 'https://google.com' }
      end

      it 'creates a webhook' do
        expect { post :create, base_params }.to change(Metova::Webhook, :count).by 1
      end
    end

    describe 'with invalid params' do
      before do
        base_params.merge! webhook: { event: nil, url: 'https://google.com' }
      end

      it 'does not create a webhook' do
        expect { post :create, base_params }.to_not change(Metova::Webhook, :count)
      end

      describe 'custom validation' do
        let(:user) { users(:logan) }
        it 'must belong to jami.couch@metova.com' do
          expect { post :create, base_params }.to_not change(Metova::Webhook, :count)
          expect(json['errors']['user']).to eq([ "must be jami" ])
        end
      end
    end
  end

  describe '#destroy' do
    let!(:webhook) { Metova::Webhook.create(event: "post:create", url: 'https://google.com', user: user) }
    before { base_params.merge! id: webhook.id }

    it 'a user can destroy their own webhooks' do
      expect { delete :destroy, base_params }.to change(Metova::Webhook, :count).by -1
    end

    it 'a user cannot destroy others webhooks' do
      webhook.update user: users(:logan)
      expect { delete :destroy, base_params }.to_not change(Metova::Webhook, :count)
    end
  end
end
