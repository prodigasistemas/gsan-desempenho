FactoryGirl.define do
  factory :usuario, class: Usuario do
    id 1
    nome "John"
    nome_usuario "john"
    senha "123456"
  end
end