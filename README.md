# XCTestsExample

# Introdução

Você já sabe criar uma classe de teste e os testes né?

Se não sabe, brevemente:

1. Vá para o Test Navigator <figura 1>
2. Na parte de baixo, clique no ícone de mais > New Unit Test Class
3. Dê um nome assim: `<nomeDaClasseASerTestada>Tests` (e.g. `SongTests`).
4. Apague o código dado (isso é sempre bom! haha)
5. Importe o seu projeto para os testes (`@testable import MyProject`) -- não precisa marcar nada como visível pro target de testes
6. Escreva bons testes, sempre começando com `test...()` e sem parâmetro e sem retorno
7. Transforme os x's vermelhos em checkmarks verdes! =D

# Testando o model: (commit: "Testing models")

A classe Song é bem simples. Basta testar se o init() tá funcionando direito, 
ou seja, se quando você passa os parâmetros, eles ficam atribuídos às properties.

# Testando o Interactor

O `SearchSongInteractor` implementa o protocolo `SearchSongInteractorInput`.
Segundo a filosofia do Clean Swift, basta testar os métodos desse protocolo
(que é o que as outras classes vão ter acesso) e isso garante que o seu código 
funciona -- fica por sua conta a reflexão se isso é realmente uma boa ideia oO.

Nesse caso, o único método do protocolo é o searchSong(). E a única coisa que 
o método faz é chamar um método no worker e depois chamar o output no completion
handler.

Do jeito que a classe está escrita, fica difícil testar. O worker está sendo 
criado dentro da chamada do método. O ideal seria esse worker ser uma property, 
ou um parâmetro do método 
[https://medium.com/ios-os-x-development/dependency-injection-in-swift-a959c6eee0ab#.inrfn2eof](Injeção de Dependência).
Vou usar a primeira opção. O Interactor vai ter uma property do tipo SearchSongWorker.
Nos testes eu vou criar o meu SearchSongWorker, que vai funcionar como Spy (ou Stub? 
não lembro agora essa nomenclatura direito, e são quase 2am. Depois você pesquisa! 
haha).

---> Correção: já era uma property. Só vou tirar a inicialização de dentro do método.

Esse foi um lado dos "relacionamentos" do Interactor. Do outro lado, existe um output
que precisa ser chamado com uma certa Response, certo?

Quando a gente for testar o Interactor, a gente precisa garantir não só que ele chama
o worker devidamente, mas que também chama o output do jeito certo. Se ele fizer essas
duas coisas ele terá feito a parte dele _like a boss_.

## O Interactor

Pra testar o interactor, a gente vai criar uma subclasse do worker
(poderia ser um protocolo esse worker hein! haha) com uma implementação 
bem particular do método searchSongs(). A 
subclasse vai ter uma property `searchSongsCalled` do tipo `Bool`, que vai servir
pra testar a coisa mais básica: se de fato o interactor está chamando esse método.
(Commit: "Testing interactor part 1")

Isso é legal, mas não é o bastante. A gente precisa garantir que o parâmetro foi 
passado corretamente e que o output está sendo chamado no completion handler.
Atenção aqui: o fato de que o bloco vai ser chamado é responsabilidade do worker
e a gente vai testar isso quando a hora chegar. Por enquanto, a nossa subclasse 
fake tem que garantir isso!
(Commit: "Testing interactor part 2")

---> Uma nota de desagrado pessoal: por que mesmo o Ray insiste em deixar as coisas
como Unwrapped Optionals? Por causa disso eu tive que adicionar o output toda vez 
mesmo que o teste não usasse. Se vc não se importar, era melhor deixar tudo optional
de verdade, com optional chaining (`output?.callWhateverMethodYouWant()`). Mas fica 
a seu critério aí. haha. =P

## O Presenter

O presenter também só tem um método e a responsabilidade é: se tiver songs, transformar
em tuplas com nome da música e nome do cantor e mandar pro output; se não tiver, mandar o
array vazio.

Na nossa classe de teste a gente chama esse método com a response vazia e com as músicas,
cria uma implementação do SearchSongsPresenterOutput e "espia" se está tudo correndo bem.
(Commit: "Testing presenter")

## O Worker

Bom, o worker aqui é bem simples. O que a gente faz? Complica! hahaha..
Na verdade, eu só vou aproveitar o fato de que ele poderia ter uma task assíncrona pra
mostrar uma coisa muito legal (mas que deve ser apreciada com moderação): As expectations.

O que você faz é declarar uma expectation com uma devida descrição, chama o bloco assíncrono
e, se tudo der certo (ou _quando_ tudo der certo), chama o método `fulfill()` na expectation.
No fim do teste, você declara quanto tempo deve ser esperado até que a expectation possa ser 
considerada "não cumprida".

O código é bem auto explicativo. Dá uma olhada.
(Commit: "Testing worker")

## O ViewController

O ViewController precisa de uns truques pra testar. Tem muitas coisas "invisíveis" 
envolvidas: carregar as views, animações, becomeFirstResponders, etc...

O que a gente faz basicamente é pegar uma instância do ViewController e carregá-la
(o que eu costumo fazer é buscar pelo identifier do storyboard e chamar a property
vc.view só pra carregar -- ela é lazy, se não chamar não acorda! haha).

Daí basta testar tudo. =D

Eu também defini um método `fail()` pra sempre que não der pra pegar o viewController
eu não usar simplesmente `guard let vc = getVC() else { return }`. Na verdade se não 
conseguir pegar o VC tem que falhar o teste, certo?
(Commit: "Testing viewController")





















