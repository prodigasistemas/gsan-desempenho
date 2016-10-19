require 'rails_helper'

describe Usuario do
  subject { build :usuario }

  context '#find' do
    it {
      expect(Usuario).to receive(:get).with([1]).and_return(get_response_json({entidade: subject.attributes}))
      expect(Usuario.find(1).nome).to eq(subject.nome)
    }

    it '#ResourceNotFound' do
      expect(Usuario).to receive(:get).with([1]).and_raise(RestClient::ResourceNotFound)
      expect(Usuario.find(1)).to be nil
    end
  end

  private

  def get_response_json(json)
    JSON.parse(json.to_json)
  end
end