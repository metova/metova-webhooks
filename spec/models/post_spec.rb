describe Post do
  describe 'on create' do
    it 'fires the create_hook method' do
      expect_any_instance_of(Post).to receive(:create_hook)
      Post.create posts(:a).attributes.except('id')
    end

    it 'performs the webhook job' do
      Metova::WebhookJob.stub :perform_later

      Post.create posts(:a).attributes.except('id')
      expect(Metova::WebhookJob).to have_received(:perform_later).with "post:create", Post.last.to_json
    end
  end

  describe 'on update' do
    it 'fires the update_hook method' do
      expect_any_instance_of(Post).to receive(:update_hook)
      posts(:a).update body: '1234'
    end

    it 'performs the webhook job' do
      Metova::WebhookJob.stub :perform_later

      posts(:a).update body: '1234'

      expect(Metova::WebhookJob).to have_received(:perform_later).with "post:update", posts(:a).to_json
    end
  end

  describe 'on destroy' do
    it 'fires the destroy_hook method' do
      expect_any_instance_of(Post).to receive(:destroy_hook)
      posts(:a).destroy
    end

    it 'performs the webhook job' do
      Metova::WebhookJob.stub :perform_later

      json = posts(:a).to_json
      posts(:a).destroy

      expect(Metova::WebhookJob).to have_received(:perform_later).with "post:destroy", json
    end
  end

  describe 'with a namespace' do
    before do
      class Post
        def namespace
          'ns'
        end
      end
    end

    it 'builds events with the namespace' do
      Metova::WebhookJob.stub :perform_later

      posts(:a).update body: '1234'

      expect(Metova::WebhookJob).to have_received(:perform_later).with "ns:post:update", posts(:a).to_json
    end
  end
end
