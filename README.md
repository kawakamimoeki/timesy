![Timesy](./docs/main.png)

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

`CLOUDINARY_CLOUD_NAME`, `CLOUDINARY_API_KEY`, `CLOUDINARY_API_SECRET` がセットされている場、Cloudinrayを利用します。

## Setup(Docker ver.)

```
gh repo clone moekidev/timesy
```

```
cd timesy
```

```
docker compose run web bin/setup
```

```
docker compose run web
```


### Setup(Host ver.)

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

このアプリは、[MITライセンス](https://opensource.org/licenses/MIT)の条件の下でオープンソースとして利用可能です。

## Code of Conduct

Timesy プロジェクトのコードベース、問題追跡システム、チャットルーム、メーリングリストで交流する全ての人々は、[行動規範](https://github.com/moekidev/timesy/blob/main/CODE_OF_CONDUCT.md)に従うことが期待されています。
