REQUISITOS MÍNIMOS
Todos os campos devem ser preenchidos com algum valor.
Algumas regras adicionais aos campos:
nome : de 3 a 30 caracteres.
email:  tem que ter um email válido.
utilize o pacote email_validator.
cpf: tem que ser um cpf válido.
utilize o pacote cnpj_cpf_helper para validar.
cep: somente 8 números.
rua: de 3 a 30 caracteres.
número: somente números.
bairro: de 3 a 30 caracteres.
cidade: de 3 a 30 caracteres.
uf: somente 2 caracteres.
país: aceitar somente Brasil (tanto faz se for caixa baixa ou alta).
Não deixar cadastrar se algum dos campos acima não passarem.
Ao cadastrar apresentar os dados do usuário em um Dialog.
Utilizar uma classe Usuario obrigatoriamente. Ao salvar preencher os atributos da classe conforme os campos em tela.

REQUISITOS DESEJÁVEIS
Todas as validações anteriores.
Quando o email for válido, carregar a imagem do avatar do serviço online Gravatar. Algumas dicas:
Entrar no site https://br.gravatar.com/;
Criar conta;
Confirmar e-mail;
Adicionar imagem;
O endereço https://www.gravatar.com/avatar/[MD5] devolve a imagem.
Para gerar o md5 do email é necessário:
email sem espaços e tudo minusculo.
mesmo email que definiu a imagem no site.
para gerar o md5 utilize o pacote crypto.
Se quiser uma imagem qualquer até que o email seja digitado no campo, pode usar o endereço https://www.gravatar.com/avatar/[RANDOM MD5]?d=robohash.
No campo cpf utilizar o pacote cnpj_cpf_formatter para validar a digitação do usuário com o InputFormatters.
Depois de digitar o cep, utilizar o serviço online ViaCep para consultar o cep e carregar os dados de endereço do usuário. Os campos rua, bairro, cidade e uf são disponibilizados pelo mesmo. Algumas dicas:
Utilize o pacote dio para fazer a requisição.
O site é https://viacep.com.br.
A url para busca é https://viacep.com.br/ws/[CEP]/json/. 
Além da classe Usuario crie outra classe Endereco para seperar os dados de endereço do usuário. Lembrando que Endereco é um atributo do Usuario.
Além do botão Cadastrar , criar um botão Limpar, que limpa todos os campos.