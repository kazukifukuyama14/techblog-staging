# GitHub Secrets 設定手順

CI/CD パイプラインを動作させるために、以下の GitHub Secrets を設定する必要があります。

## 必要な Secrets

### AWS 認証情報

| Secret 名               | 値        | 説明                                   |
| ----------------------- | --------- | -------------------------------------- |
| `AWS_ACCESS_KEY_ID`     | `AKIA...` | IAM ユーザーのアクセスキー ID          |
| `AWS_SECRET_ACCESS_KEY` | `...`     | IAM ユーザーのシークレットアクセスキー |

## 設定手順

### 1. GitHub リポジトリで Secrets を設定

1. GitHub リポジトリページに移動
2. **Settings** タブをクリック
3. 左サイドバーの **Secrets and variables** → **Actions** をクリック
4. **New repository secret** をクリック

### 2. AWS_ACCESS_KEY_ID の設定

1. **Name**: `AWS_ACCESS_KEY_ID`
2. **Secret**: `credentials/iam-users/techblog-staging_accessKeys.csv`ファイルの`Access key ID`の値
3. **Add secret** をクリック

### 3. AWS_SECRET_ACCESS_KEY の設定

1. **Name**: `AWS_SECRET_ACCESS_KEY`
2. **Secret**: `credentials/iam-users/techblog-staging_accessKeys.csv`ファイルの`Secret access key`の値
3. **Add secret** をクリック

## 認証情報の確認

### CSV ファイルの場所

```csv
credentials/iam-users/techblog-staging_accessKeys.csv
```

### CSV ファイルの形式

```csv
User name,Password,Access key ID,Secret access key,Console login link
techblog-staging,,AKIA...,wJalrXUt...,https://...
```

## セキュリティ注意事項

⚠️ **重要**:

- 認証情報は絶対にコードにハードコーディングしないでください
- CSV ファイルは`.gitignore`で除外されているため、GitHub にはアップロードされません
- GitHub Secrets は暗号化されて保存され、ワークフロー実行時のみアクセス可能です

## 設定確認

Secrets が正しく設定されているかは、以下の方法で確認できます：

1. **Settings** → **Secrets and variables** → **Actions**
2. 以下の Secrets が表示されることを確認：
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`

## トラブルシューティング

### ワークフローが失敗する場合

1. **AWS 認証エラー**:

   - Secrets の値が正しいか確認
   - IAM ユーザーの権限が適切か確認

2. **S3 アクセスエラー**:

   - バケット名が正しいか確認
   - S3 への書き込み権限があるか確認

3. **CloudFront アクセスエラー**:
   - ディストリビューション ID が正しいか確認
   - CloudFront の無効化権限があるか確認

## 参考リンク

- [GitHub Actions Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [AWS IAM ベストプラクティス](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)
