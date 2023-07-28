![Timesy](./public/ogp.jpg)

**Timesy**は開発者のためのマイクロブログサービスです。

## Requirement

- Ruby 3.2.2
- Bundler 2.4.7

or

- Docker
- Docker Compose

### Email

[Sendgrid](https://sendgrid.kke.co.jp/) or [MailCatcher](https://mailcatcher.me/)

`SENDGRID_API_KEY` という環境変数が設定されていれば、Sendgridを利用します。

### Storage

[Cloudinary](https://cloudinary.com/) or local

`CLOUDINARY_CLOUD_NAME`, `CLOUDINARY_API_KEY`, `CLOUDINARY_API_SECRET` がセットされている場、Cloudinaryを利用します。

## Development (Docker ver.)

```sh
gh repo clone moekidev/timesy
```

```sh
cd timesy
```

```sh
docker compose run --rm web bin/setup
```

```sh
docker compose up
```

## Development (Host ver.)

```sh
gh repo clone moekidev/timesy
```

```sh
cd timesy
```

`.env`ファイルを用意します。

```sh
cp .env.example .env
```

以下の環境変数が必要なので適宜設定してください。

```sh
# Site configuration
SITE_SENDER_EMAIL="noreply@example.com" # optional

# Database configuration
DATABASE_URL="postgresql://postgres:postgres@localhost:5432/postgres" # example

# Third party API keys
SENDGRID_API_KEY="" # optional
CLOUDINARY_CLOUD_NAME="" # optional
CLOUDINARY_API_KEY="" # optional
CLOUDINARY_API_SECRET="" # optional
```

Postgres 15のサーバーを立ち上げてください。

以下はHomebrewを使った場合です。

```sh
brew services start postgresql@15
```

Railsなどのセットアップを行います。

```sh
bin/setup
```

ここまで来たら、サーバーを立ち上げることができます。

```sh
bin/dev
```

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=moekidev/timesy&type=Date)](https://star-history.com/#moekidev/timesy&Date)

## Contribution

バグ報告やプルリクエストは、GitHubの https://github.com/moekidev/timesy にお願いします。このプロジェクトは、コラボレーションのための安全で歓迎的な空間を目指しており、貢献者は[行動規範](https://github.com/moekidev/timesy/blob/main/CODE_OF_CONDUCT.md)を守ることが期待されています。

## License

このアプリは、[MITライセンス](https://opensource.org/licenses/MIT)の条件の下でオープンソースとして利用可能です。

## Code of Conduct

Timesy プロジェクトのコードベース、問題追跡システム、チャットルーム、メーリングリストで交流する全ての人々は、[行動規範](https://github.com/moekidev/timesy/blob/main/CODE_OF_CONDUCT.md)に従うことが期待されています。
