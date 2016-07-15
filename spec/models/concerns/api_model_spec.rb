require 'rails_helper'

describe "API::Model" do
  subject { Model.new }

  let(:retorno_find) { create(:model).marshal_dump.to_json }

  it { expect(retorno_find["nome"]).to eq "John" }
end