require 'rails_helper'

describe ContratoMedicao do
  subject { build :contrato_medicao }

  context '#find' do
    it {
      expect(ContratoMedicao).to receive(:get).with([1]).and_return(get_response_json({entidade: subject.attributes}))
      expect(ContratoMedicao.find(1).numero).to eq(subject.numero)
    }

    it '#ResourceNotFound' do
      expect(ContratoMedicao).to receive(:get).with([1]).and_raise(RestClient::ResourceNotFound)
      expect(ContratoMedicao.find(1)).to be nil
    end
  end

  context '#create' do
    it {
      params = subject.attributes
      expect(ContratoMedicao).to receive(:post)
                                  .with([], { "contrato_medicao" => params })
                                  .and_return(get_response_json({entidade: subject.attributes}))
      expect(ContratoMedicao.create(params).numero).to eq(subject.numero)
    }

    it "RestClient::UnprocessableEntity" do
      params = subject.attributes
      params.delete(:numero)
      subject.errors = ActiveModel::Errors.new(subject)

      expect(ContratoMedicao).to receive(:post)
                                  .with([], { "contrato_medicao" => params })
                                  .and_return(get_response_json({entidade: subject.attributes}))

      entidade = ContratoMedicao.create(params)
      expect(entidade.valid?).to be false
    end
  end

  describe ".iniciar_coeficientes" do
    let(:ligacoes_agua_1) { LigacaoAguaSituacao.new(id: 1, descricao: "Normal") }
    let(:ligacoes_agua_2) { LigacaoAguaSituacao.new(id: 2, descricao: "Anormal") }

    let(:ligacoes_agua) do
      [ligacoes_agua_1, ligacoes_agua_2]
    end

    it { expect(ContratoMedicao.iniciar_coeficientes(ligacoes_agua).first.ligacao_agua_situacao.id).to eq(ligacoes_agua_1.id) }
    it { expect(ContratoMedicao.iniciar_coeficientes(ligacoes_agua).first.ligacao_agua_id).to eq(ligacoes_agua_1.id) }
    it { expect(ContratoMedicao.iniciar_coeficientes(ligacoes_agua).last.ligacao_agua_situacao.id).to eq(ligacoes_agua_2.id) }
    it { expect(ContratoMedicao.iniciar_coeficientes(ligacoes_agua).last.ligacao_agua_id).to eq(ligacoes_agua_2.id) }
  end

  private

  def get_response_json(json)
    JSON.parse(json.to_json)
  end
end