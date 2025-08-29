# 👤 IAMユーザー管理

このディレクトリには、プロジェクトで使用するIAMユーザーの認証情報が格納されています。

## 📋 現在のIAMユーザー

### techblog-staging-user

- **用途**: CI/CDパイプライン用
- **権限**: TechBlogStaging-Policy-Limited（推奨）または TechBlogStaging-Policy-Admin
- **アクセスキー**: `techblog-staging_accessKeys.csv`に格納

## 🔑 アクセスキーの管理

### ファイル構成

```
techblog-staging_accessKeys.csv
├── Access key ID: [20文字の英数字]
├── Secret access key: [40文字の英数字]
└── 作成日: [YYYY-MM-DD]
```

### 使用方法

#### GitHub Actionsでの設定

```yaml
# .github/workflows/deploy.yml
env:
  AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
  AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
  AWS_DEFAULT_REGION: ap-northeast-1
```

#### ローカル環境での設定

```bash
# AWS CLI設定
aws configure

# 以下の情報を入力
AWS Access Key ID: [CSVファイルのAccess key ID]
AWS Secret Access Key: [CSVファイルのSecret access key]
Default region name: ap-northeast-1
Default output format: json
```

## 🔄 アクセスキーのローテーション

### 定期ローテーション（90日ごと）

1. **新しいアクセスキーを生成**
   ```bash
   aws iam create-access-key --user-name techblog-staging-user
   ```

2. **新しいアクセスキーを設定**
   - GitHub Secretsの更新
   - ローカル環境の更新
   - CI/CDパイプラインのテスト

3. **古いアクセスキーを無効化**
   ```bash
   aws iam update-access-key --user-name techblog-staging-user --access-key-id [古いキーID] --status Inactive
   ```

4. **古いアクセスキーを削除**
   ```bash
   aws iam delete-access-key --user-name techblog-staging-user --access-key-id [古いキーID]
   ```

### 緊急ローテーション（漏洩時）

1. **即座にアクセスキーを無効化**
   ```bash
   aws iam update-access-key --user-name techblog-staging-user --access-key-id [漏洩したキーID] --status Inactive
   ```

2. **新しいアクセスキーを生成・設定**
   - 上記の定期ローテーション手順を実行

3. **影響範囲の確認**
   - CloudTrailログで不正アクセスの有無を確認
   - 必要に応じてリソースの再作成

## 📊 監視・ログ

### CloudTrailの有効化

```bash
# CloudTrailの作成
aws cloudtrail create-trail \
  --name techblog-staging-trail \
  --s3-bucket-name techblog-staging-logs \
  --region ap-northeast-1

# ログ記録の開始
aws cloudtrail start-logging --name techblog-staging-trail
```

### 監視項目

- **認証失敗**: 不正なアクセス試行
- **権限エラー**: 権限不足による操作失敗
- **異常なアクセスパターン**: 通常と異なる時間・場所からのアクセス

## 🚨 セキュリティチェックリスト

### 日常的な確認

- [ ] アクセスキーが90日以内に更新されている
- [ ] 使用していないIAMユーザーが存在しない
- [ ] 必要最小限の権限のみ付与されている
- [ ] CloudTrailログが正常に記録されている

### 月次確認

- [ ] IAMユーザーの権限見直し
- [ ] アクセスキーの使用状況確認
- [ ] セキュリティログの分析
- [ ] ベストプラクティスの適用状況

## 📚 参考資料

- [AWS IAM ベストプラクティス](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)
- [アクセスキーの管理](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html)
- [CloudTrail の設定](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-tutorial.html)

---

**セキュリティ第一**: IAMユーザーの管理は慎重に行い、定期的な見直しを実施してください。
