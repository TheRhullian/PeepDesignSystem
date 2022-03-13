# Criação de Componentes
Com o seu projeto configurado, você terá acesso ao Target CEAUIKitComponents, onde usará para desenvolver e exemplificar o seu componente.
Para começar o processo de desenvolvimento do seu componente siga os seguintes passos:
##1. Criação de branch
Crie uma branch com o código da sua task no submodulo do CEAUIKit.
##2. Desenvolvimento do Componente
Importante seguir os padrões definidos e regras de integração:

    1. Crie um ViewController que terá o seu componente integrado, nela você ajudará outros a verem como utilizar o que foi desenvolvido.

    2. Adicione esse ViewController à tabela principal.

    3. Dentro do seu componente, utilize private lazy var para adicionar outros componentes internamente.

    4. Não deixe strings soltas dentro do componente, crie um private enum Strings e adicione todos os textos.

    5. Não deixe valores soltos dentro do componente, crie um private enum Constants e adicione todos os valores como: Cores, Fontes, Alturas, Margens e etc.

    6. Priorize o uso dos valores no CEADimens para Margens, CornerRadius e Altura/Largura de Ícones.

    7. Utilize cores já configuradas nos Assets.

##3. Entrega do seu componente
Para poder fazer a entrega, é preciso:

    1. Ter adicionado o componente com sucesso no CEAUIKitComponents para documentação.

    2. Ter testado o seu componente na tela da feature em desenvolvimento.

Após isso, crie um PR da branch no submodulo do CEAUIKit para a master e adicione 2 revisores, sendo que um deles precisa ser o Tech Lead.