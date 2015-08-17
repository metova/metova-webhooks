describe Metova::Webhook, type: :model do
  it { is_expected.to belong_to :user }

  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :event }
  it { is_expected.to validate_presence_of :url }
end
