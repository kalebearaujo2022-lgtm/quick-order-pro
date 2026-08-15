# Quick Order Pro

Crie uma plataforma web completa chamada ATENDENTE VIRTUAL, voltada para donos de restaurantes, hamburguerias, pizzarias, lanchonetes e outros estabelecimentos de alimentação.

O objetivo é criar uma plataforma moderna onde o restaurante possa disponibilizar seu cardápio online e os clientes possam realizar pedidos, personalizar produtos, escolher entrega ou retirada, acompanhar pedidos, avaliar a experiência e receber benefícios.

O sistema deve funcionar perfeitamente em computadores, notebooks, tablets e celulares, utilizando design responsivo e abordagem mobile-first.

1. IDENTIDADE E DESIGN

Nome da plataforma:

Atendente Virtual

Crie uma identidade visual moderna, tecnológica, profissional e gastronômica.

O design deve ser:

Chamativo

Moderno

Elegante

Intuitivo

Rápido

Responsivo

Visualmente agradável

Utilize fotos grandes e chamativas de hambúrgueres, pizzas, pratos, bebidas e outros alimentos, com excelente qualidade visual.

Utilize cards modernos, animações suaves, microinterações e efeitos de hover, mas sem exagerar para não prejudicar a velocidade.

Crie uma interface que transmita:

"Escolha. Personalize. Peça. Acompanhe."

2. PÁGINA INICIAL

Criar uma Home Page profissional contendo:

Logo Atendente Virtual

Menu de navegação

Botão "Ver Cardápio"

Botão "Fazer Pedido"

Botão "Entrar"

Botão "Cadastrar"

Botão do WhatsApp

Seletor de idioma

Alternância entre modo claro e escuro

Criar uma seção principal com uma imagem grande e chamativa de comida.

Título:

"Seu pedido do seu jeito."

Subtítulo:

"Escolha seus pratos favoritos, personalize seu pedido e acompanhe tudo em um só lugar."

Adicionar botão:

"Ver Cardápio"

Criar também seções:

Mais vendidos

Promoções

Categorias

Combos

Benefícios

Avaliações

Últimos pedidos

Programa de recompensas

3. BANCO DE DADOS

Utilize um banco de dados real e estruturado.

Criar as seguintes entidades/tabelas:

CLIENTES

Campos:

ID

Nome

E-mail

Telefone

Senha/autenticação

Endereço

Cidade

CEP

Data de cadastro

Pontos

Favoritos

Histórico de pedidos

Preferências

Cupons

RESTAURANTES

Campos:

ID

Nome

Logo

Imagem de capa

Descrição

Endereço

Telefone

WhatsApp

Horário de funcionamento

Taxa de entrega

Status aberto/fechado

PRODUTOS

Campos:

ID

Restaurante

Nome

Descrição

Categoria

Preço

Imagem

Ingredientes

Status

Quantidade vendida

Destaque

Promoção

ADICIONAIS

Campos:

ID

Produto

Nome

Descrição

Preço

Status

PEDIDOS

Campos:

ID

Cliente

Restaurante

Produtos

Quantidades

Adicionais

Observações

Subtotal

Desconto

Taxa de entrega

Total

Forma de pagamento

Tipo de recebimento

Endereço

Status

Data

Horário

AVALIAÇÕES

Campos:

ID

Cliente

Restaurante

Pedido

Nota

Comentário

Foto

Data

CUPONS

Campos:

ID

Código

Tipo de desconto

Valor

Validade

Limite de utilização

Status

RECOMPENSAS

Campos:

ID

Cliente

Pontos

Prêmio

Cupom

Data

Status

4. LOGIN E CADASTRO

Criar sistema completo de autenticação.

O cliente poderá:

Criar conta

Fazer login

Recuperar senha

Editar perfil

Alterar endereço

Visualizar pedidos

Visualizar favoritos

Visualizar pontos

Visualizar cupons

Visualizar notas fiscais

Visualizar avaliações

Criar também uma área específica para o dono do restaurante administrar seu estabelecimento.

5. CARDÁPIO

Criar um cardápio visual e moderno.

Categorias:

Hambúrgueres

Pizzas

Combos

Porções

Bebidas

Sobremesas

Promoções

Cada produto deve apresentar:

Foto

Nome

Descrição

Preço

Avaliação

Botão "Adicionar"

Adicionar:

Busca

Filtros

Categorias

Mais vendidos

Promoções

Favoritos

6. PERSONALIZAÇÃO DOS PRODUTOS

Quando o cliente clicar em um produto, abrir uma página ou modal detalhado.

Mostrar:

Foto grande

Nome

Descrição

Ingredientes

Preço

Avaliações

Criar opções para personalizar o pedido.

Exemplo para hambúrguer:

Escolha o pão

Tradicional

Brioche

Integral

Escolha o queijo

Cheddar

Mussarela

Prato

Adicionais

Bacon

Cebola

Ovo

Molho especial

Batata

Bebida

Remover ingredientes

Permitir também:

Quantidade

Observações especiais

Cada adicional deve alterar automaticamente o preço.

Exemplo:

Hambúrguer: R$ 25,00

Bacon: R$ 5,00

Cheddar: R$ 4,00

Batata: R$ 8,00

Total atualizado automaticamente.

Botão:

"Adicionar ao Carrinho"

7. CARRINHO DE COMPRAS

Criar um carrinho completo e fácil de utilizar.

O cliente poderá:

Adicionar produtos

Remover produtos

Alterar quantidade

Editar adicionais

Visualizar subtotal

Aplicar cupom

Visualizar desconto

Visualizar taxa de entrega

Visualizar valor final

Criar botão:

"Finalizar Pedido"

No celular, criar um botão flutuante mostrando a quantidade de itens no carrinho.

8. ENTREGA OU RETIRADA

Durante a finalização do pedido, perguntar:

"Como você deseja receber seu pedido?"

Criar duas opções:

🛍️ Retirar no balcão

Mostrar:

Endereço

Horário

Tempo estimado

Instruções para retirada

🛵 Entrega

Solicitar:

Endereço

Número

Complemento

Bairro

CEP

Ponto de referência

Mostrar automaticamente:

Taxa de entrega

Tempo estimado

Valor total

9. PAGAMENTO

Criar uma etapa de pagamento.

Opções:

Pix

Cartão

Dinheiro

Pagamento na retirada

Pagamento na entrega

Se o cliente escolher dinheiro, perguntar:

"Precisa de troco?"

10. RASTREAMENTO DO PEDIDO

Criar uma página chamada:

"Acompanhe seu pedido"

Mostrar uma linha do tempo:

Pedido recebido
↓
Pedido confirmado
↓
Preparando
↓
Pronto
↓
Saiu para entrega
↓
Entregue

Para retirada:

Pedido recebido
↓
Preparando
↓
Pronto para retirada
↓
Retirado

Mostrar:

Número do pedido

Produtos

Valor

Forma de pagamento

Tipo de recebimento

Tempo estimado

As alterações de status feitas pelo restaurante devem aparecer para o cliente.

11. ÚLTIMOS PEDIDOS

Criar uma área:

"Meus últimos pedidos"

Mostrar:

Data

Número do pedido

Produtos

Valor

Status

Restaurante

Adicionar botão:

"Pedir novamente"

Ao clicar, adicionar automaticamente os mesmos produtos e suas configurações ao carrinho.

12. MAIS VENDIDOS

Criar uma seção:

🔥 Mais vendidos

Os produtos devem ser classificados automaticamente com base na quantidade de vendas.

Mostrar:

Foto

Nome

Avaliação

Preço

Quantidade vendida

Botão "Adicionar"

13. NOTA FISCAL DIGITAL

Criar uma área chamada:

"Minhas Notas Fiscais"

Depois de um pedido concluído, disponibilizar a nota fiscal digital vinculada ao pedido.

Permitir:

Visualizar

Baixar

Consultar

As notas devem ficar disponíveis no histórico do cliente.

Caso a emissão fiscal real dependa de integração externa, preparar a arquitetura para integração com um serviço fiscal posteriormente, sem simular uma nota fiscal oficial.

14. ROLETA DE PRÊMIOS

Criar uma funcionalidade chamada:

🎁 Roleta de Prêmios

O cliente poderá girar uma roleta e ganhar benefícios.

Prêmios possíveis:

5% de desconto

10% de desconto

15% de desconto

Frete grátis

Batata grátis

Bebida grátis

Adicional grátis

Tente novamente

Registrar cada tentativa no banco de dados.

Criar regras para impedir abuso.

Os prêmios devem gerar cupons reais utilizáveis no checkout.

15. MURAL DE AVALIAÇÕES

Criar uma seção:

⭐ Mural de Avaliações

O cliente poderá:

Dar nota de 1 a 5 estrelas

Escrever comentário

Enviar foto do pedido

Mostrar avaliações reais cadastradas no banco de dados.

Criar filtros:

Mais recentes

Melhores avaliações

Com fotos

16. WHATSAPP

Adicionar um botão flutuante do WhatsApp.

O número deve ser configurável pelo restaurante.

Quando o cliente clicar, abrir diretamente o WhatsApp do estabelecimento.

Mensagem inicial:

"Olá! Estou entrando em contato pelo Atendente Virtual."

O botão deve estar disponível principalmente nas páginas:

Home

Cardápio

Produto

Pedido

Checkout

17. ACESSIBILIDADE

Criar um menu de acessibilidade.

Adicionar:

Aumentar fonte

Diminuir fonte

Alto contraste

Reduzir animações

Destacar links e botões

Melhorar contraste

Leitura de conteúdo

Navegação facilitada

Criar um botão de acessibilidade fixo e facilmente identificável.

As configurações devem ser salvas para o usuário.

18. MODO CLARO E ESCURO

Adicionar:

☀️ Modo Claro
🌙 Modo Escuro

O usuário poderá alternar quando quiser.

Salvar a preferência.

Garantir que todos os componentes sejam legíveis e visualmente bonitos nos dois modos.

19. IDIOMAS

Adicionar suporte para:

🇧🇷 Português
🇺🇸 English

Criar seletor de idioma.

Traduzir toda a interface:

Menu

Botões

Cardápio

Produtos

Carrinho

Checkout

Pedidos

Perfil

Notificações

Mensagens

Acessibilidade

Salvar a preferência do usuário.

20. NAVEGAÇÃO FACILITADA

A navegação precisa ser extremamente simples.

No celular:

Criar menu inferior fixo:

🏠 Início
🍔 Cardápio
🛒 Carrinho
📦 Pedidos
👤 Perfil

No computador:

Criar menu superior ou lateral.

Adicionar:

Busca rápida

Categorias

Botão voltar

Breadcrumbs quando necessário

Carrinho sempre acessível

Botões grandes e claros

O usuário deve conseguir chegar ao cardápio e ao carrinho rapidamente.

21. NOTIFICAÇÕES

Criar notificações para:

Pedido recebido

Pedido confirmado

Pedido em preparação

Pedido pronto

Pedido saiu para entrega

Pedido entregue

Promoções

Cupons

Recompensas

22. PERFIL DO CLIENTE

Criar:

Meu Perfil

Com:

Informações pessoais

Endereços

Pedidos

Favoritos

Cupons

Pontos

Recompensas

Notas fiscais

Avaliações

23. FAVORITOS

Permitir que o cliente favorite produtos.

Criar seção:

❤️ Meus Favoritos

Cada item deve possuir:

"Adicionar ao Carrinho"

24. PLANOS PARA RESTAURANTES

Criar uma página:

"Planos"

Criar exatamente 3 planos.

🟢 PLANO ESSENCIAL

Para pequenos estabelecimentos.

Incluir:

Cardápio digital

Cadastro de produtos

Sistema de pedidos

Carrinho

Cadastro de clientes

Histórico de pedidos

WhatsApp

Modo claro e escuro

Suporte básico

🔵 PLANO PROFISSIONAL

Para restaurantes em crescimento.

Incluir tudo do Essencial +

Rastreamento de pedidos

Programa de fidelidade

Roleta de prêmios

Cupons

Avaliações

Relatórios

Nota fiscal digital

Personalização avançada

Suporte prioritário

Adicionar selo:

⭐ MAIS ESCOLHIDO

🟣 PLANO PREMIUM

Para restaurantes que querem mais controle e crescimento.

Incluir tudo do Profissional +

Dashboard avançado

Análise de vendas

Produtos mais vendidos

Relatórios avançados

Campanhas promocionais

Fidelização avançada

Automação de marketing

Recursos avançados para clientes

Suporte premium

Todos os planos devem possuir botão:

"Começar agora"

Criar comparação visual entre os três planos.

25. PAINEL DO RESTAURANTE

Criar um dashboard exclusivo para o dono do restaurante.

Mostrar:

Pedidos de hoje

Faturamento

Clientes

Ticket médio

Produtos vendidos

Produtos mais vendidos

Pedidos pendentes

Pedidos concluídos

Avaliações

Cupons utilizados

Criar gráficos modernos.

26. GERENCIAMENTO DO CARDÁPIO

O restaurante poderá:

Criar produto

Editar produto

Excluir produto

Alterar preço

Alterar foto

Criar categorias

Criar adicionais

Criar promoções

Ativar/desativar produtos

27. GERENCIAMENTO DE PEDIDOS

Criar painel para o restaurante acompanhar pedidos.

Filtros:

Pendentes

Confirmados

Preparando

Prontos

Em entrega

Entregues

Cancelados

O restaurante poderá atualizar o status.

A atualização deve aparecer automaticamente para o cliente no rastreamento.

28. RESPONSIVIDADE

O projeto deve funcionar perfeitamente em:

Celulares Android

iPhone

Tablets

Notebooks

Computadores

No celular:

Menu inferior

Carrinho flutuante

Botões grandes

Checkout simplificado

Imagens adaptadas

No computador:

Layout amplo

Dashboard completo

Menu profissional

Cards organizados

29. EXPERIÊNCIA DO CLIENTE

O fluxo principal deve ser:

ENTRAR

↓

ESCOLHER RESTAURANTE

↓

VER CARDÁPIO

↓

ESCOLHER PRODUTO

↓

PERSONALIZAR

↓

ADICIONAR AO CARRINHO

↓

ESCOLHER ENTRE ENTREGA OU RETIRADA

↓

PAGAR

↓

ACOMPANHAR PEDIDO

↓

RECEBER PEDIDO

↓

AVALIAR

↓

GANHAR RECOMPENSA

↓

PEDIR NOVAMENTE

Esse fluxo deve ser rápido, intuitivo e funcionar perfeitamente em dispositivos móveis.

30. REQUISITOS TÉCNICOS

Utilize uma arquitetura organizada e escalável.

O banco de dados deve possuir relacionamentos corretos entre:

Restaurantes

Clientes

Produtos

Adicionais

Pedidos

Itens dos pedidos

Avaliações

Cupons

Recompensas

Notas fiscais

Implementar autenticação e controle de acesso.

Cada restaurante deve ter acesso somente aos seus próprios:

Clientes

Produtos

Pedidos

Avaliações

Cupons

Relatórios

O cliente deve ter acesso somente aos seus próprios dados.

Não utilizar dados fictícios como se fossem dados reais.

Utilizar dados de demonstração apenas quando necessário para apresentar o design.

Preparar o sistema para integração futura com:

WhatsApp

Gateway de pagamento

Serviços de emissão fiscal

Serviços de entrega

Notificações

31. RESULTADO FINAL

O resultado deve parecer um produto SaaS profissional pronto para ser apresentado a donos de restaurantes.

Não criar apenas uma landing page.

Criar uma plataforma funcional, com:

Área pública

Área do cliente

Área do restaurante

Banco de dados

Autenticação

Cardápio

Carrinho

Checkout

Pedidos

Rastreamento

Avaliações

Roleta

Cupons

Fidelidade

Nota fiscal digital

Dashboard

Modo claro

Modo escuro

Português/Inglês

Acessibilidade

WhatsApp

Design responsivo

Priorize velocidade, simplicidade, segurança, usabilidade e uma aparência extremamente profissional.

Antes de finalizar, teste o fluxo completo de cadastro → login → escolha do produto → personalização → carrinho → entrega/retirada → pagamento → pedido → rastreamento → avaliação.

Garanta que as informações sejam persistidas corretamente no banco de dados e que as alterações feitas pelo restaurante apareçam corretamente para o cliente.

WHATSAPP DO ESTABELECIMENTO

Configure o botão de WhatsApp do site para abrir diretamente uma conversa com o seguinte número:

+55 68 99239-0173

Quando o cliente clicar no botão de WhatsApp, abrir automaticamente o WhatsApp nesse número.

Utilizar o formato internacional do número para gerar o link corretamente:

+5568992390173

Mensagem inicial sugerida:

"Olá! Vim pelo Atendente Virtual e gostaria de falar com o estabelecimento."

O botão deve:

Aparecer de forma destacada no site.

Funcionar em celular e computador.

Abrir o aplicativo do WhatsApp quando disponível.

Abrir o WhatsApp Web quando acessado pelo computador.

Permanecer acessível nas principais páginas do site.

Não alterar o número automaticamente.

Utilizar exclusivamente o número +55 68 99239-0173.

This project was built with [Lovable](https://lovable.dev).

## Build with Lovable

Continue developing this project in the [Lovable editor](https://lovable.dev/projects/6b0e9c61-94ea-4f1b-ad25-ce94d2a73283).

- **Ship faster**: describe what you want to build and Lovable handles the code.
- **Stay in sync**: every change made in Lovable is committed straight to this repository.
- **Full ownership**: this code is yours. Push to `main` on GitHub and your changes sync back into Lovable, ready for your next prompt.

## Development

Prefer working locally? You need Node.js and npm — [install with nvm](https://github.com/nvm-sh/nvm#installing-and-updating).

```sh
git clone <this-repository-url>
cd <repository-name>
npm i
npm run dev
```
