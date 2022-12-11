# catolica_mhc

Projeto PAC 4a Fase do App de Horas Complementares, desenvolvido no curso de Engenharia de Software.

### Equipe de desenvolvimento 

- Davi Prudente Ferreira [https://github.com/Davi-PF]
- Fernanda Corrêa Borges 
- Marcos Paulo Gonçalves Junior 
- Victor Hugo Bosse Kühn
- Wesley Erik Sardi



## Instruções básicas

Ao realizar o clone do repositório para seu dispositivo, será necessário ir ao arquivo pubspec.yaml e realizar o  `pub get` das dependências. Obs.: caso necessário, após dar `pub get`, dê `pub upgrade`. Além disso, há uma dependência chamada `get`, que precisa ser da versão `^3.26.0`, então caso a versão dela seja alterada, é necessário defini-la como a versão citada para não dar problemas.

Para realizar o login na aplicação, será utilizado o email: `usuario_teste@gmail.com`; e a senha: `teste123`.

O dispositivo utilizado para testes, do android emulator é foi o: `Pixel 3a API 31`.

Caso de o problema de Null Sound Safety, será necessário fazer esse passo a passo:

## Primeiro passo:

- Ir em `Run`, no topo do Android Studio e ir em `Edit configurations`.

### Imagem de exemplo: 

![alt text](imgs_readme/passo1_null-sound-safety.png)


## Segundo Passo:

- Após acessar a área de edição de configurações, adicione no campo `additional run args` o seguinte: `--no-null-sound-safety`

![alt text](imgs_readme/passo2_null-sound-safety.png)
