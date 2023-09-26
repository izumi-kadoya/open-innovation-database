# アプリケーション名
open-innovation-database

# アプリケーション概要
・＜本アプリの主な目的＞csv形式の企業データを、本アプリで見やすく確認するため
・csv形式の企業データをアップロードし、複数人で確認できます。編集やコメントもできます。  
・ユーザー権限機能があり、管理者ユーザーのみがデータのアップロードを行うことができます。  
・セキュリティ面を重視し、管理者ユーザーに承認されたユーザーのみが主な機能を使うことができます。 
## 紹介動画(2分50秒)
https://youtu.be/jc7LF1O-PAU

# URL
<テスト用>
https://open-innovation-database.onrender.com
＜本番用（本番稼働用ですので、サインアップや試用はお控えください）＞
http://18.176.12.135/

# テスト用アカウント
・Basic認証ID  admin  
・Basic認証PW  5555  
・メールアドレス  test@test.com  
・パスワード  123456  
・アップロード用csv  
[sample-data.csv](https://github.com/izumi-kadoya/open-innovation-database/files/12616004/sample-data.csv)
 
# 利用方法
## 企業情報のアップロード・閲覧・コメント付与
### csvのアップロード
・ログイン済の管理者ユーザーが、「admin」ボタンを経由してアップロード専用ページへ移動します。  
・アップロードしたいcsvファイルを選択してアップロードしてください。  
### アップロード済ファイルを閲覧
・トップページには、アップロード済の企業名が表示されます。  
・業種での絞り込みや、名前を昇順に並べること（デフォルト状態）、アップロードした日付降順に並べることもできます。  
・詳細を閲覧したい企業の名前をクリックしてください。  
### スタートアップの一覧を確認
・詳細画面には、企業が出資したスタートアップの一覧が表示されます。  
・詳細を確認したいスタートアップを選択してください。  
### スタートアップの詳細を確認
・スタートアップの情報を確認できます。 URLリンクや、企業の概要などが示されています。 URLリンクや、企業の概要などが示されています。  
・大きな字で表示されているスタートアップ名にカーソルを合わせると、更なる詳細情報が表示されます。  
・More description　をクリックすると、ページ下部にスタートアップの概要が表示されます。こちらはRPAを用いて、google　bardで作成した内容を記入していますので、bardが文章を作成できない際はその旨がそのまま表示されることがあります。読み上げたい時は再生アイコンをクリックしてください。  
・Article Summary　をクリックすると、ページ下部にスタートアップに投資した際の記事の要約が表示されます。こちらはRPAを用いて、google　bardで作成した内容を記入していますので、bardが文章を作成できない際はその旨がそのまま表示されることがあります。読み上げたい時は再生アイコンをクリックしてください。  
・「Update」ボタンをクリックすることで、chatGPTと連携し、情報を再取得します。再取得した情報はページ下部に表示されます。  
・「Save」ボタンをクリックすることで、表示された内容を現在のデータに上書きすることができます。
### コメント機能
・クライアントの要望に合わせ、短いコメント３つ、長いコメント１つの合計４つのコメント欄を設けています。短いコメント欄には、スタートアップのカテゴリ等を入力してください。長いコメントは、自由に記入できる欄として利用できます。これらは全ユーザーで共有のコメントとなります。  
・「edit」ボタンを押下すると、ページ読み込みなしで編集モードに切り替わります。  
・コメントを記入または編集し、「save」ボタンを押下することで編集完了となります。  
・再度編集を行いたいときは、ページをリロードしてください。  
## ユーザー機能
### 概要
本アプリは１企業内で使用するため、外部のユーザーをブロックするためのユーザー認証機能を設けています。
### ユーザー区分
・管理者ユーザー：すべての操作が可能。csvのアップロードや他ユーザーへの権限付与やユーザーアカウントの取消も行うことができます。  
・一般ユーザー：データの閲覧やコメントが可能。csvのアップロードやユーザー権限の変更機能はありません。csvデータの作成を行わないスタッフや、一時的に利用するインターン生等の利用を想定しています。  
・未承認ユーザー：Sign upを行っただけのユーザーです。トップページとスタートアップ一覧のページのみ閲覧できます。他のページに移動しようとするとトップページにリダイレクトされます。管理者ユーザーに承認してもらうことで、管理者ユーザーや一般ユーザーになることができます。  

# アプリケーションを作成した背景
・製作者の夫の要望により作成いたしました。  
・スタートアップへの投資情報を知りたい時、手作業でWebページからExcelデータ２種類をダウンロードし統合したものをExcel上で確認せざるを得ませんでした。作業に時間がかかる上、Excelで情報が横並びになっており見づらいといった問題がありました。  
・まず、Windows Power Automate Desktop上でデータを自動DLし、１ファイルにまとめるようにしました。  
・次に、本アプリケーションで必要な情報を見やすく配置し、また、 コメントを記入し共有できるようにいたしました。  
・実際に夫の会社で運用していただく予定になっています。
 
# 洗い出した要件、画面遷移図
・要件　https://docs.google.com/spreadsheets/d/1oaTIrUe-QuXtiXcp63cuuNNZqhajICt6igWrkO41zu8/edit?usp=sharing  
<img width="1086" alt="画面遷移図" src="https://github.com/izumi-kadoya/open-innovation-database/assets/140796896/ed2d7cf4-1138-46d4-a991-f5030388d606">


# データベース設計
![ ER ](https://github.com/izumi-kadoya/open-innovation-database/assets/140796896/22dfdebb-cafb-48e0-b35b-6257819169b0)




# 実装予定の機能
・自然な音声での読み上げが可能なサービスへのAPI連携の切り替え　→ 9/20 済
・記事内容を再取得する

# ローカルでの作動方法
・ターミナルにて以下を実行してください  
　% git clone https://github.com/izumi-kadoya/open-innovation-database.git  
　% cd open-innovation-database  
　% bundle install  
・アプリケーションを開き、「Sign up」ボタンから新規登録を行なってください。  
・新規登録したユーザーは管理者ユーザーでも一般ユーザーでもないため、まずは権限を付与してください。  
・テーブルを直接開き、登録したユーザーの「admin」と「approved」をそれぞれ「１（True）」に変更してください。

# RPAで行っていること（参考まで）
・まず、調べたい企業のリストをエクセルシートに記述します。  
・RPAを起動させます。以下は全て自動で行われます。  
（１）エクセルシートにあるURLへアクセスし、企業ごとに日付などの条件を絞り込み、以下の２種類の情報をエクセルでダウンロードします。  
　①企業が投資した記事の情報  
　②投資した先のスタートアップの企業情報  
（２）RPA上でエクセルマクロを起動させ、上記①と②の情報を統合させます。  
（３）統合したデータは、企業名の名前がついたCSVファイルとして保存します。  
・続いて、スタートアップ企業の詳細情報や記事の要約をRPAで取得します。以下は全て自動で行われます。  
（１）CSVファイルから、スタートアップ企業のURL情報を取得します。  
（２）ブラウザでGoogle Bardを開き、スタートアップ企業のURLを使って、企業の概要を記載するよう指示します。  
（３）Google Bardが作成した文章をコピーし、csvに記入します。  
（４）続いて、CSVファイルから、投資に関する記事の情報を取得します。 
（５）Google Bardを開き、記事について、詳しい内容を記載するよう指示します。  
（６）Google Bardが作成した文章をコピーし、csvに記入します。  
（７）本アプリにアップロードする形式に整えます。  
（８）出来上がりファイルをCSV形式で保存します。


# 工夫したポイント
・RPAからWEBアプリケーションまでを全て独力で完成させました。クライアントの求めることを逐次確認し、全体の流れを理解した上で製作できたためスムーズでした。  
・一般に広く公開するアプリではないため、ユーザーの権限に制限をかけることを徹底いたしました。  
・ビュー画面では、あえてはじめに表示される情報を少なくすることで、すっきりとした見た目を実現しました。  
・不必要な可能性のある情報についてはすぐに表示させないことで、「文字が多すぎて読むのが大変」・「見るだけでうんざりする」といった状況を回避しました。  
・さらに、長い文章が入ることが想定されてる箇所は読み上げ機能を活用することで、目が疲れた時などに文章を読まなくても良いように工夫しました。  
・詳細情報や分量の多い情報を閲覧するときは、javascriptを用いてリロードなしで表示されており、ユーザーエクスペリエンスの向上を目指しました。  


