describe Metova::WebhookJob do
  subject { Metova::WebhookJob.new }

  it 'fires matching webhooks' do
    uri_double = instance_double(URI)
    URI.stub parse: uri_double
    Net::HTTP.stub :post_form
    matching = Metova::Webhook.create(event: "post:create", url: 'https://google.com', user: users(:jami))
    non_matching = Metova::Webhook.create(event: "post:update", url: 'https://other.url', user: users(:jami))

    payload = { 'one' => 'two' }

    subject.perform matching.event, payload.to_json

    expect(URI).to have_received(:parse).with matching.url
    expect(Net::HTTP).to have_received(:post_form).with uri_double, payload

    expect(URI).to_not have_received(:parse).with non_matching.url
  end

  it 'handles exceptions by logging' do
    allow(Net::HTTP).to receive(:post_form).and_raise("exception")
    Rails.logger.stub :error
    hook = Metova::Webhook.create(event: "post:create", url: 'https://google.com', user: users(:jami))

    subject.perform hook.event, {}.to_json

    expect(Rails.logger).to have_received(:error)
  end
end
