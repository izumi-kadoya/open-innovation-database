# アプリケーション名
open-innovation-database

# アプリケーション概要
　・csv形式の企業データをアップロードし、複数人で確認できます。編集やコメントもできます。  
　・ユーザー権限機能があり、管理者ユーザーのみがデータのアップロードを行うことができます。  
　・セキュリティ面を重視し、管理者ユーザーに承認されたユーザーのみが主な機能を使うことができます。 

# URL
https://open-innovation-database.onrender.com

# テスト用アカウント
・Basic認証ID  admin
・Basic認証PW  5555
・メールアドレス  test@test.com
・パスワード  123456
・アップロード用csv 
[sample-data.csv](https://github.com/izumi-kadoya/open-innovation-database/files/12616004/sample-data.csv)
  最下部にtextを記載


　※但し、こちらのアプリケーションは実際に利用予定のため、ローカルのみでアップロードを行ってください。本番環境でのアップロードは行わないでください。  
 
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
　・▶️ For more description　をクリックすると、ページ下部にスタートアップの概要が表示されます。こちらはRPAを用いて、google　bardで作成した内容を記入していますので、bardが文章を作成できない際はその旨がそのまま表示されることがあります。  
　・▶️ Article Summary　をクリックすると、ページ下部にスタートアップに投資した際の記事の要約が表示されます。こちらはRPAを用いて、google　bardで作成した内容を記入していますので、bardが文章を作成できない際はその旨がそのまま表示されることがあります。  
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
![ ER ](https://github.com/izumi-kadoya/open-innovation-database/assets/140796896/6828b4c0-3894-4ca7-bfac-df1fa6ee382e)

# 実装予定の機能
・API連携し、RPA稼働時にGoogle Bardからうまく取得できなかった情報について、再取得して上書き保存する機能

# ローカルでの作動方法
　・ターミナルにて以下を実行してください  
　　% git clone https://github.com/izumi-kadoya/open-innovation-database.git  
　　% cd open-innovation-database  
　　% bundle install  
　・アプリケーションを開き、「Sign up」ボタンから新規登録を行なってください。  
　　新規登録したユーザーは管理者ユーザーでも一般ユーザーでもないため、まずは権限を付与してください。  
　・テーブルを直接開き、登録したユーザーの「admin」と「approved」をそれぞれ「１（True）」に変更してください。

# RPAで行うこと
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
　・ビュー画面では、あえてはじめに表示される情報を少なくすることで、すっきりとした見た目を実現しました。  
　・不必要な可能性のある情報についてはすぐに表示させないことで、「文字が多すぎて読むのが大変」・「見るだけでうんざりする」といった状況を回避しました。  
　・詳細情報や分量の多い情報を閲覧するときは、javascriptを用いてリロードなしで表示されており、ユーザーエクスペリエンスの向上を目指しました。  

# テスト用csvデータ
以下をテキストエディタなどのアプリケーションにコピーし、テスト用CSVを作成してください。
company_industry,company_name,article_date,business_partner,company_type,country,news_snippet,url,description,business_description,article_summary,text,sector,industry,sub_industry,competitors,founded_year,latest_funding_round,latest_funding_date,latest_funding_amount,latest_funding_simplified_round,latest_funding_investors,total_funding,all_investors,link_date,link,expert_tag,date_added,added_by,date_last_edited,last_edited_by,company_status,exit_date,acquirers,latest_valuation,country,city,comment1,comment2,comment3,comment4
Non-life Insurance,companyA,45106,partnerA,Vendor,United States,This is news_snippet,sample.com,This is description,This is business_description,This is article_summary,0,Healthcare,This is industry,Hospitals,0,2013,Grant - IV,43724,2,Grant,investorA,6,investorB,0,0,0,45178,sample,45178,sample,Alive / Active,0,0,0,United States,NY,1,2,3,4
Non-life Insurance,companyA,45106,partnerB,Vendor,United States,This is news_snippet,sample.com,This is description,This is business_description,This is article_summary,0,Healthcare,This is industry,Hospitals,0,2013,Grant - IV,43724,2,Grant,investorA,6,investorB,0,0,0,45178,sample,45178,sample,Alive / Active,0,0,0,United States,NY,1,2,3,4
Non-life Insurance,companyA,45106,partnerC,Vendor,United States,This is news_snippet,sample.com,This is description,This is business_description,This is article_summary,0,Healthcare,This is industry,Hospitals,0,2013,Grant - IV,43724,2,Grant,investorA,6,investorB,0,0,0,45178,sample,45178,sample,Alive / Active,0,0,0,United States,NY,1,2,3,4
Life and Health Insurance,companyA,45106,partnerA,Vendor,United States,This is news_snippet,sample.com,This is description,This is business_description,This is article_summary,0,Healthcare,This is industry,Hospitals,0,2013,Grant - IV,43724,2,Grant,investorA,6,investorB,0,0,0,45178,sample,45178,sample,Alive / Active,0,0,0,United States,NY,1,2,3,4
Life and Health Insurance,companyA,45106,partnerB,Vendor,United States,This is news_snippet,sample.com,This is description,This is business_description,This is article_summary,0,Healthcare,This is industry,Hospitals,0,2013,Grant - IV,43724,2,Grant,investorA,6,investorB,0,0,0,45178,sample,45178,sample,Alive / Active,0,0,0,United States,NY,1,2,3,4
Non-life Insurance,companyB,45106,partnerA,Vendor,United States,This is news_snippet,sample.com,This is description,This is business_description,This is article_summary,0,Healthcare,This is industry,Hospitals,0,2013,Grant - IV,43724,2,Grant,investorA,6,investorB,0,0,0,45178,sample,45178,sample,Alive / Active,0,0,0,United States,NY,1,2,3,4
