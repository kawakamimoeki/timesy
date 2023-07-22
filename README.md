![Timesy](./docs/main.png)

**Timesy**は「できた！」の瞬間を共有できるマイクロブログサービスです。

## Development

### Requirement

- Ruby 3.2.2
- Bundler 2.4.7

### Third party tools

以下のサービスのAPIにアクセスできる状態にしておいてください。ローカル環境でもこれらのツールを利用しています。

- [Sendgrid](https://sendgrid.kke.co.jp/)
- [Cloudinary](https://cloudinary.com/)

### Setup

```
gh repo clone moekidev/timesy
```

```
cd timesy
```

`.env`ファイルを用意します。

```
cp .env.example .env
```

以下の環境変数が必要なので適宜設定してください。

```
# Database configuration
DATABASE_URL="postgresql://postgres:postgres@localhost:5432/postgres"

# Third party API keys
SENDGRID_API_KEY=""
CLOUDINARY_CLOUD_NAME=""
CLOUDINARY_API_KEY=""
CLOUDINARY_API_SECRET=""
```

Postgres 15のサーバーを立ち上げてください。

以下はHomebrewを使った場合です。

```
brew services start postgresql@15
```

Railsなどのセットアップを行います。

```
bin/setup
```

### Server

ここまで来たら、サーバーを立ち上げることができます。

```
bin/dev
```

## Contribution

バグ報告やプルリクエストは、GitHubのhttps://github.com/moekidev/timesy にお願いします。このプロジェクトは、コラボレーションのための安全で歓迎的な空間を目指しており、貢献者は[行動規範](https://github.com/moekidev/timesy/blob/main/CODE_OF_CONDUCT.md)を守ることが期待されています。

## License

このgemは、[MITライセンス](https://opensource.org/licenses/MIT)の条件の下でオープンソースとして利用可能です。

## Code of Conduct

Timesy プロジェクトのコードベース、問題追跡システム、チャットルーム、メーリングリストで交流する全ての人々は、[行動規範](https://github.com/moekidev/timesy/blob/main/CODE_OF_CONDUCT.md)に従うことが期待されています。
