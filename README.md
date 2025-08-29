# 🚀 AWS + Hugo テックブログ（Staging 環境）

AWS と Hugo を組み合わせた低コスト・高パフォーマンスな静的テックブログの**staging 環境**です。  
ローカル開発・テスト用途に特化し、本番環境への移行を前提とした構成となっています。

## ✨ 特徴

- **🔄 静的サイト生成**: Hugo による高速ビルド
- **☁️ AWS インフラ**: S3 + CloudFront による高可用性
- **🛠️ Infrastructure as Code**: Terraform による管理
- **🚀 CI/CD**: GitHub Actions による自動デプロイ
- **💰 コスト最適化**: AWS 無料枠を最大限活用
- **📚 包括的ドキュメント**: 要件定義から運用まで網羅

## 🏗️ 技術スタック

| カテゴリ             | 技術              | 用途                     |
| -------------------- | ----------------- | ------------------------ |
| **静的サイト生成**   | Hugo              | Markdown から HTML 生成  |
| **クラウドインフラ** | Amazon S3         | 静的ファイルホスティング |
| **CDN**              | Amazon CloudFront | 高速配信・キャッシュ     |
| **認証・認可**       | AWS IAM           | リソースアクセス制御     |
| **監視・ログ**       | Amazon CloudWatch | メトリクス・ログ管理     |
| **インフラ管理**     | Terraform         | AWS リソースのコード化   |
| **CI/CD**            | GitHub Actions    | 自動ビルド・デプロイ     |
| **バージョン管理**   | Git               | ソースコード管理         |

## 🚀 クイックスタート

### 前提条件

- AWS CLI（最新版）
- Terraform（1.0.0 以上）
- Hugo（最新版）
- Git（最新版）

### 初期セットアップ

```bash
# リポジトリのクローン
git clone https://github.com/kazukifukuyama14/techblog-staging.git
cd techblog-staging

# developブランチに切り替え
git checkout develop

# 依存関係のインストール（必要に応じて）
# AWS CLI、Terraform、Hugoのインストール

# 環境設定
cp .env.example .env  # 環境変数ファイルの作成
# .envファイルを編集してAWS認証情報を設定

# インフラ構築
cd terraform
terraform init
terraform plan
terraform apply

# Hugoサイトの作成
cd ../hugo-site
hugo new site . --force
hugo server -D  # ローカル確認
```

## 📁 プロジェクト構成

```bash
techblog-staging/
├── README.md                    # このファイル
├── .gitignore                   # Git除外設定
├── doc/                         # プロジェクトドキュメント
│   ├── README.md               # ドキュメント構成説明
│   ├── requirements/           # 要件定義系
│   │   ├── README.md          # プロジェクト概要
│   │   ├── 技術仕様書.md      # 技術要件・非機能要件
│   │   └── 構築手順書.md      # 段階的構築手順
│   ├── design/                 # 設計系
│   │   ├── システム設計書.md  # 全体アーキテクチャ
│   │   ├── インフラ設計書.md  # AWSリソース設計
│   │   └── データ設計書.md    # Hugoサイト構造
│   └── operation/              # 運用系
│       └── 運用・保守手順書.md # 日常運用作業
├── terraform/                   # インフラ設定
│   ├── main.tf                 # メイン設定
│   ├── variables.tf            # 変数定義
│   ├── outputs.tf              # 出力定義
│   └── modules/                # 再利用可能モジュール
├── hugo-site/                   # Hugoサイト
│   ├── config.toml             # Hugo設定
│   ├── content/                 # コンテンツ
│   ├── layouts/                 # レイアウト
│   ├── static/                  # 静的ファイル
│   └── themes/                  # テーマ
├── .github/                     # GitHub設定
│   └── workflows/              # GitHub Actions
└── docs/                        # 追加ドキュメント
```

## 📚 ドキュメント

詳細なドキュメントは [`doc/`](./doc/) ディレクトリに格納されています：

- **📋 要件定義**: 技術仕様、構築手順
- **🏗️ 設計書**: システム設計、インフラ設計、データ設計
- **🛠️ 運用**: 日常運用作業、監視、障害対応

## 🔧 開発・デプロイ

### ローカル開発

```bash
# Hugoサーバー起動
cd hugo-site
hugo server -D

# ブラウザで http://localhost:1313 にアクセス
```

### デプロイ

```bash
# 変更をコミット・プッシュ
git add .
git commit -m "feat: 新機能の追加"
git push origin feature/新機能名

# GitHubでプルリクエスト作成 → レビュー → マージ
# GitHub Actionsが自動でデプロイ実行
```

## 🎯 学習・転職活動での活用

### 技術力のアピールポイント

- **AWS**: S3、CloudFront、IAM、CloudWatch の実践的活用
- **インフラ**: Terraform による Infrastructure as Code
- **CI/CD**: GitHub Actions による自動化
- **静的サイト**: Hugo による高速なサイト生成
- **ドキュメント**: 包括的な技術文書の作成・管理

### プロジェクト管理能力

- 要件定義から運用まで一貫した設計
- 段階的な構築手順の文書化
- 適切なブランチ戦略とプルリクエスト運用

## 🤝 貢献

1. このリポジトリをフォーク
2. 機能ブランチを作成 (`git checkout -b feature/新機能`)
3. 変更をコミット (`git commit -m 'feat: 新機能の追加'`)
4. ブランチにプッシュ (`git push origin feature/新機能`)
5. プルリクエストを作成

## 📄 ライセンス

このプロジェクトは MIT ライセンスの下で公開されています。

## 🔗 関連リンク

- [Hugo 公式サイト](https://gohugo.io/)
- [AWS 公式ドキュメント](https://docs.aws.amazon.com/)
- [Terraform 公式ドキュメント](https://www.terraform.io/docs)
- [GitHub Actions 公式ドキュメント](https://docs.github.com/ja/actions)

---

**Happy Coding!**🚀
