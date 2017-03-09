Criar um aplicativo de consulta a API do GitHub.

Criar um aplicativo para consultar a API do GitHub e trazer os reposit√≥rios mais populares de Swift. Basear-se no mockup fornecido:

### Deve conter ###
-  Lista de reposit√≥rios. Exemplo de chamada na API : https://api.github.com/search/repositories?q=language:Swift&sort=stars&page=1    
- Pagina√ß√£o na tela de lista, com endless scroll / scroll infinito (incrementando o par√¢metro page).    
- Cada reposit√≥rio deve exibir Nome do reposit√≥rio, Descri√ß√£o do Reposit√≥rio, Nome / Foto do autor, N√∫mero de Stars, N√∫mero de Forks
- Ao tocar em um item, deve levar a lista de Pull Requests do reposit√≥rio
- Pull Requests de um reposit√≥rio. Exemplo de chamada na API: https://api.github.com/repos/<criador>/<reposit√≥rio>/pulls
-    Cada item da lista deve exibir Nome / Foto do autor do PR, T√≠tulo do PR, Data do PR e Body do PR
-    Ao tocar em um item, deve abrir no browser a p√°gina do Pull Request em quest√£o

### A solu√ß√£o de acordo com o cargo ###

##### Junior #####

- Configura√ß√£o
- Vers√£o m√≠nima do iOS : 9.*
- App para Iphone
- Arquivo .gitignore
- Gest√£o de depend√™ncias no projeto Ex: CocoaPods
- Persistir os dados no CoreData
- Exibir os dados do CoreData caso o app esteja offline
- Usar Storyboard
- Framework para Comunica√ß√£o com API. Ex: Alamofire
- Mapeamento json -> Objeto . Ex: Gloss

##### Pleno #####
- Todos de Junior
- Utilizar AutoLayout (Constraints SizeClasses)
- App Universal iPhone | Ipad
- Testes unit√°rios no projeto. Ex: XCTests
- Utilizar MVC
- Isolar chamadas de rede
- Coment√°rios

##### S√™nior #####
- Todos os de Pleno e Junior
- App Universal iPhone | iPad | Landscape | Portrait (Size Classes)
- Testes de interface. Ex: UI Tests

### Sugest√µes ###
As sugest√µes de bibliotecas fornecidas s√£o s√≥ um guideline, sintam-se a vontade para usar diferentes e nos surpreenderem. O importante de fato √© que os objetivos macros sejam atingidos. :smiley:

### Processo de submiss√£o ###
O candidato dever√° implementar a solu√ß√£o e enviar um pull request para este reposit√≥rio com a solu√ß√£o.
O processo de Pull Request funciona da seguinte maneira:
1. Candidato far√° um fork desse reposit√≥rio (n√£o ir√° clonar direto!)

2. Far√° seu projeto nesse fork.

3. Commitar√° e subir√° as altera√ß√µes para o SEU fork.

4. Pela interface do Bitbucket, ir√° enviar um Pull Request.

Se poss√≠vel deixar o fork p√∫blico para facilitar a inspe√ß√£o do c√≥digo.

**ATEN√á√ÉO**
N√£o se deve tentar fazer o PUSH diretamente para ESTE reposit√≥rio!
