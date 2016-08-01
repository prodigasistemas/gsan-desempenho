require 'rails_helper'

describe FiltroImovelPresenter do

  describe "#matricula" do
    context "quando existir matricula" do
      let(:params) do
        {
          query: { 
            id: "121212",
            quadra: {
              rota_id: "1"
            }
          }
        }
      end

      subject(:filtro) { FiltroImovelPresenter.new(params) }

      it "retorna a matricula do imovel" do
        expect(filtro.matricula).to eq params[:query][:id]
      end
    end

    context "quando nao existir matricula" do
      let(:params) do
        {
          
        }
      end

      subject(:filtro) { FiltroImovelPresenter.new(params) }

      it "retorna a matricula do imovel" do
        expect(filtro.matricula).to be nil
      end
    end
  end

  describe "#localidade" do
    context "quando existir localidade" do
      let(:params) do
        {
          query: { 
            localidade_id: "1",
            quadra: {
              rota_id: "1"
            }
          },
          localidade: "Abel"
        }
      end

      subject(:filtro) { FiltroImovelPresenter.new(params) }

      it "retorna a localidade do imovel" do
        expect(filtro.localidade).to eq params[:localidade]
      end

      it "retorna o id da localidade do imovel" do
        expect(filtro.localidade_id).to eq params[:query][:localidade_id]
      end
    end

    context "quando nao existir localidade" do
      let(:params) do
        {
          
        }
      end

      subject(:filtro) { FiltroImovelPresenter.new(params) }

      it "retorna nulo" do
        expect(filtro.localidade_id).to be nil
        expect(filtro.localidade).to be nil
      end
    end
  end

  describe "#setor_comercial" do
    context 'quando existir setor comercial' do

      let(:params) do
        {
          query: { 
            setor_comercial_id: "1",
            quadra: {
              rota_id: "1"
            }
          },
          setor_comercial: "SETOR OMEGA"
        }
      end

      subject(:filtro) { FiltroImovelPresenter.new(params) }

      it "retorna o setor comercial do imovel" do
        expect(filtro.setor_comercial).to eq params[:setor_comercial]
      end

      it "retorna o id do setor comercial do imovel" do
        expect(filtro.setor_comercial_id).to eq params[:query][:setor_comercial_id]
      end
      
    end

    context 'quando nao existir setor' do
      let(:params) do
        {
          
        }
      end

      subject(:filtro) { FiltroImovelPresenter.new(params) }

      it "retorna nulo" do
        expect(filtro.setor_comercial).to be nil
        expect(filtro.setor_comercial_id).to be nil
      end

    end
  end

  describe "#rota" do
    context 'quando existir rota' do
      let(:params) do
        {
          query: { 
            quadra: {
              rota_id: "1"
            }
          },
          rota: "ROTA 01"
        }
      end

      subject(:filtro) { FiltroImovelPresenter.new(params) }

      it "retorna a rota" do
        expect(filtro.rota).to eq params[:rota]
      end

      it "retorna o id da rota" do
        expect(filtro.rota_id).to eq params[:query][:quadra][:rota_id]
      end
    end

    context 'quando nao exitir rota' do
      let(:params) do
        {
          
        }
      end

      subject(:filtro) { FiltroImovelPresenter.new(params) }

      it "retorna nulo" do
        expect(filtro.rota).to be nil
        expect(filtro.rota_id).to be nil
      end

    end
  end

  describe "#quadra" do
    context 'quando existir quadra' do
      let(:params) do
        {
          query: { 
            qdra_id: "1",
            quadra: {
              rota_id: ""
            }
          },
          quadra: "13133"
        }
      end

      subject(:filtro) { FiltroImovelPresenter.new(params) }

      it "retorna o numero da quadra" do
        expect(filtro.quadra).to eq params[:quadra]
      end

      it "retorna o id da quadra" do
        expect(filtro.quadra_id).to eq params[:query][:qdra_id]
      end
    end

    context 'quando nao existir quadra' do
      let(:params) do
        {
          
        }
      end

      subject(:filtro) { FiltroImovelPresenter.new(params) }

      it "retorna nulo" do
        expect(filtro.quadra_id).to be nil
      end

    end
  end

  describe "#lote" do
    context 'quando existir lote' do
      let(:params) do
        {
          query: { 
            numero_lote: "112",
            quadra: {
              rota_id: ""
            }
          }
        }
      end

      subject(:filtro) { FiltroImovelPresenter.new(params) }

      it "retorna o lote" do
        expect(filtro.numero_lote).to eq params[:query][:numero_lote]
      end
    end

    context 'quando nao existir lote' do
      let(:params) do
        {
          
        }
      end

      subject(:filtro) { FiltroImovelPresenter.new(params) }

      it "retorna nulo" do
        expect(filtro.numero_lote).to be nil
      end
    end
  end

  describe "#sublote" do
    context 'quando existir sublote' do
      let(:params) do
        {
          query: { 
            numero_sublote: "112",
            quadra: {
              rota_id: ""
            }
          }
        }
      end

      subject(:filtro) { FiltroImovelPresenter.new(params) }

      it "retorna o sublote" do
        expect(filtro.numero_sublote).to eq params[:query][:numero_sublote]
      end
    end

    context 'quando nao existir sublote' do
      let(:params) do
        {
          
        }
      end

      subject(:filtro) { FiltroImovelPresenter.new(params) }

      it "retorna nulo" do
        expect(filtro.numero_sublote).to be nil
      end
    end
  end
  
end