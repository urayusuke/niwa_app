# Name: flutter-m3-design-expert
# Description: FlutterアプリのUI設計、画面レイアウトの構築、またはMaterial Design 3 (M3) の実装を行う際に自動的に呼び出されるスキル。単なるコンポーネント配置ではなく、UX品質を考慮した提案とコード生成を行います。

---

## 原則

- MVP: iOS / Android スマートフォン専用。アダプティブ対応・`flutter_adaptive_scaffold` 導入はしない
- `ThemeData(useMaterial3: true)` 前提。ColorRoles・タイポグラフィスケールを正しく使う
- タップ領域 48px 以上・コントラスト比 4.5:1 以上を守る
- Niwa 固有のカラー・サイズ・テキストは CLAUDE.md の AppColors / AppSizes / AppText を使う

## コンポーネント選定

| やりたいこと | 使うべきM3コンポーネント |
|---|---|
| 単一選択 | `SegmentedButton` / `ChoiceChip` |
| 複数選択 | `FilterChip` |
| 主要アクション | `FilledButton` |
| カード | `Card`（Filled / Elevated / Outlined） |
| 下からせり上がるUI | `showModalBottomSheet` |
| リスト項目 | `ListTile` |
| 通知 | `ScaffoldMessenger.showSnackBar` |
| アイコンタップ | `IconButton`（GestureDetector 禁止） |

## 実装ルール

- `ColorScheme` のロールを使う（直接ハードコード禁止）
- `textTheme.headlineMedium` 等 M3 スケールを使う（`fontSize` 直指定禁止）
- 画面遷移には `animations` パッケージ（`SharedAxisTransition`）を使う
- `const` を積極的に使う。`build` メソッドは100行以内
- リストは `ListView.builder`（`Column` + `SingleChildScrollView` 禁止）
- `setState` 禁止 → Riverpod `select` で必要部分だけ監視
- 画面遷移は go_router で管理（push/pop 禁止）

## 作業フロー

1. どの画面・コンポーネントか把握する
2. CLAUDE.md で Niwa 固有仕様を確認する
3. M3 コンポーネントを選んだ理由を 1 行説明する
4. コード生成 → アクセシビリティ確認
