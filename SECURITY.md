# 🔒 セキュリティガイドライン

## ⚠️ 重要なセキュリティ警告

**このプロジェクトには機密情報が含まれています。以下の点を必ず守ってください：**

### 🚨 絶対にやってはいけないこと

- **認証情報の Git 管理**: AWS アクセスキー、シークレットキーを Git にコミットしない
- **機密ファイルの共有**: 認証情報を含むファイルを他の人と共有しない
- **パブリックリポジトリ**: 機密情報を含む状態でパブリックリポジトリにしない
- **ハードコーディング**: コード内に認証情報を直接記述しない

### ✅ 正しい管理方法

#### 1. 認証情報の管理

```bash
credentials/                    # ローカル環境でのみ管理
├── iam-users/
│   └── techblog-staging_accessKeys.csv  # Git管理対象外
└── README.md                  # 管理手順（Git管理対象外）
```

#### 2. 環境変数の使用

```bash
# .envファイル（Git管理対象外）
AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret_key
AWS_DEFAULT_REGION=ap-northeast-1
```

#### 3. GitHub Secrets の活用

```yaml
# .github/workflows/deploy.yml
env:
  AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
  AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

## 🔐 セキュリティチェックリスト

### コミット前の確認

- [ ] 認証情報が含まれていない
- [ ] 環境変数ファイルが除外されている
- [ ] 機密ファイルが除外されている
- [ ] .gitignore が適切に設定されている

### 定期的な確認

- [ ] アクセスキーが 90 日以内に更新されている
- [ ] 使用していない IAM ユーザーが削除されている
- [ ] 必要最小限の権限のみ付与されている
- [ ] CloudTrail ログが有効になっている

## 🚨 緊急時の対応

### 認証情報が漏洩した場合

1. **即座にアクセスキーを無効化**

   ```bash
   aws iam update-access-key --user-name USERNAME --access-key-id ACCESS_KEY_ID --status Inactive
   ```

2. **新しいアクセスキーを生成**

   ```bash
   aws iam create-access-key --user-name USERNAME
   ```

3. **影響範囲の確認**

   - CloudTrail ログで不正アクセスの有無を確認
   - 必要に応じてリソースの再作成

4. **セキュリティ監査の実施**
   - 全 IAM ユーザーの権限見直し
   - アクセスログの詳細分析

## 📚 セキュリティベストプラクティス

### AWS IAM

- **最小権限の原則**: 必要最小限の権限のみ付与
- **アクセスキーのローテーション**: 90 日ごとの更新
- **条件付きアクセス**: IP アドレス制限の設定
- **監査ログ**: CloudTrail の有効化

### コード管理

- **機密情報の除外**: .gitignore での適切な設定
- **環境変数の活用**: ハードコーディングの回避
- **シークレット管理**: GitHub Secrets 等の活用
- **定期的な監査**: セキュリティチェックの実施

## 🔍 セキュリティ監査ツール

### 静的解析

- **GitGuardian**: コミット内の機密情報検出
- **TruffleHog**: Git 履歴内の機密情報検索
- **AWS Config**: AWS リソースの設定監査

### 動的監視

- **CloudTrail**: API 呼び出しのログ記録
- **CloudWatch**: メトリクスとログの監視
- **AWS Security Hub**: セキュリティの統合監視

## 📞 セキュリティインシデントの報告

セキュリティの問題を発見した場合は、以下の手順で報告してください：

1. **即座の対応**: 影響範囲の特定と最小化
2. **詳細調査**: 原因と影響範囲の分析
3. **報告**: チームへの報告と対応策の検討
4. **再発防止**: 同様の問題の再発防止策の実施

---

**セキュリティ第一**: 常にセキュリティを最優先に考え、機密情報の管理には細心の注意を払ってください。
