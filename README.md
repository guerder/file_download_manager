`ATENÇÃO: O package file_download_manager é de uso interno e não está publicado em pub.dev.`

# File Download Manager

file_download_manager é uma abstração do package flutter_download_manager para possibilitar o uso na plataforma web, além de simplificar algumas configurações como o diretório de destino dos arquivos baixados para cada plataforma.

## Integration Android

### Android 13
  
  Devido a mudança no permissionamento no android 13 não está sendo possível baixar arquivos em pasta visível ao usuário. Logo que a biblioteca permission_handler atualizar será possível ajustar essa necessidade.
  

### Permissão para salvar no dispositivo

Foi removido a necessidade de permissões nas versões inferiores ao Android 13.
Está sendo utilizado o plugin `file_android` para salvar os arquivos na pasta de mídias (Movies, Pictures, Music) para o usuário ter acesso após o download.
  
</details>

## Getting started

Declare essa dependência no arquivo pubspec.yaml

```yaml
dependencies:
  file_download_manager:
    git: https://github.com/guerder/file_download_manager.git
```

## Usage

Por ser uma classe de instância única, basta chamar a função desejada a partir da classe FileDownloader.

```dart
    FileDownloader().downloadFromUrl(url: url);
```

Adicionalmente pode ser referenciada uma função no atributo `onStart` para ser executada quando o download for iniciado, como por exemplo a exibição de aviso na tela do usuário. Da mesma forma pode ser passado um callback no atributo `onDone` que é chamado no fim do download.

```dart
    FileDownloader().downloadFromUrl(url: url, onStart: () {}, onDone: () {});
```

## TODO

- [ ] Atender as plataformas Android, iOS, Web, Mac, Windows e Linux - Falta apenas testes
- [ ] Adicionar permissões para download no Android 13 - permission_handler
- [ ] Exibir o progresso do download como notificação - flutter_local_notifications
- [ ] Criar um código de exemplo de uso da biblioteca

