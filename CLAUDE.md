# Niwa — CLAUDE.md

Flutter アプリ「Niwa」の開発ルール。このファイルを常に参照すること。

@docs/app-spec.md
@docs/api-spec.md
@docs/db-spec.md
@.claude/skills/flutter-m3-design-expert.md

---

## 1. アーキテクチャ（厳守）

### ディレクトリ構成

```
lib/
├── app/
│   ├── routes/           # go_router のみ
│   └── services/         # Firebase初期化・グローバルProvider
├── features/
│   └── [feature_name]/
│       ├── models/       # Freezedモデルのみ
│       ├── repository/   # Firestore操作のみ
│       ├── state/        # State + Notifier（1ファイル）
│       └── screens/      # ConsumerWidget（UIのみ）
├── common/
│   ├── constants/        # 色・文言・サイズ・設定値
│   └── widgets/          # 共有ウィジェット
└── main.dart
```

### 禁止事項

- `bindings/` `utils/` `helpers/` `extensions/` など指定外のディレクトリは作成しない
- `screens/` にロジックを書かない（`ref.watch` して表示するだけ）
- `repository/` に状態管理を書かない（Firestore操作のみ）
- 文字列・数値・色のハードコード禁止（定数ファイルを使う）
- `print()` 禁止（`debugPrint()` を使う）
- 相対インポート禁止（`package:niwa_app/...` で統一）
- 招待制機能は実装しない（Phase 2以降）

### 各レイヤーの責務

| レイヤー | 責務 | 書いてはいけないもの |
|---|---|---|
| `models/` | Freezedデータ構造のみ | ビジネスロジック・Firebase依存 |
| `repository/` | Firestore CRUD | 状態管理・UI |
| `state/` | Stateクラス＋Notifier（1ファイル） | Firestore直接操作・UI |
| `screens/` | UIの描画のみ | ロジック・Firestore操作 |

---

## 2. Freezed 規約

- `fromFirestore` はモデルに書かない。Repositoryで変換する（モデルはデータ構造のみ、Firebase依存を持ち込まない）
- 状態更新は必ず `copyWith` を使う（全フィールド書き直し禁止）
- State と Notifier は1ファイルにまとめる（`xxx_state.dart`）

### コード生成

```bash
dart run build_runner watch --delete-conflicting-outputs
```

---

## 4. コーディングスタイル

### 条件分岐・制御フロー
- 条件分岐は `if` を優先する。軽微な場合（1行で済む）のみ三項演算子
- **早期リターン**を意識して、ネストを浅く保つ
- アロー関数（`=>`）は使わない。`onPressed` 等も `{ }` ブロックで書く

```dart
// ❌
onPressed: () => context.push(AppRoute.settings),

// ✅
onPressed: () {
  context.push(AppRoute.settings);
},
```

### エラーハンドリング
- `try-catch` は**例外が発生しうる処理**（外部API・Firebase書き込み等）のみ使う
- 通常の判定はレスポンス結果（`null` チェック・戻り値）で行う
- `catch` は対処が必要な場合のみ。握りつぶさない

```dart
// ❌ 通常フローにtry-catchを使う
try {
  final user = await getUser();
} catch (e) { ... }

// ✅ 戻り値で判定
final user = await getUser();
if (user == null) return;
```

### メソッドチェーン・フォーマット
- メソッドチェーンは**繋げすぎない** → 途中で変数に切り出す
- 末尾カンマを積極的に入れて、改行・整形を徹底する

```dart
// ❌ 繋げすぎ
return _col.where('date', isEqualTo: date).orderBy('createdAt', descending: true).snapshots().map((snap) => snap.docs.map(Record.fromFirestore).toList());

// ✅ 変数に切り出し＋末尾カンマ
final query = _col
    .where('date', isEqualTo: date,)
    .orderBy('createdAt', descending: true,);

return query
    .snapshots()
    .map((snap) => snap.docs.map(Record.fromFirestore).toList());
```

### ウィジェット分割
- 画面内のウィジェットは**分割しすぎない**
- シート・カードなど意味のある単位では分割してよいが、その内部（header / content など）はインラインで書く
- 親ウィジェットの `build` 内に直接書いて、構造が一目でわかるようにする

---

*Niwa CLAUDE.md — 2026年3月*
