# Darknet 環境構築 on Windows

+ 以下のリンクにアップデートバージョンを公開しています。

[https://ichiya.netlify.com/posts/2019/10/28/_20191028.html](https://ichiya.netlify.com/posts/2019/10/28/_20191028.html)

<br>

<br>

（2019 / 6 / 25 現在）

<br>

*Description :* 
+ <a href="https://github.com/kazuya0202/setup-darknet.git" target="_blank">kazuya0202/setup-darknet.git</a>
+ Visual Studio 2019をインストールする予定の場合は先にインストールしておいた方が良い

<br>

| Install Libraries | Version |
| :---------------: | :-----: |
|       CUDA        |  10.0   |
|       cuDNN       |  7.6.1  |
|      OpenCV       |  3.4.6  |

<br>

<br>

## CUDA セットアップ

1. <a href="https://developer.nvidia.com/cuda-10.0-download-archive?target_os=Windows&target_arch=x86_64&target_version=10&target_type=exenetwork" target="_blank">NVIDIA Toolkit - CUDA10.0 Archive</a> からインストーラをダウンロード

2. Version : `10` ／ Installer Type : `exe [network]` を選択し、Base Installer をダウンロード![1561460159013](https://github.com/kazuya0202/setup-darknet/blob/master/images/1561460159013.png)

3. ダウンロードしたインストーラを起動

4. 展開先フォルダの指定

    + デフォルトのままで`OK`をクリックする。

5. ライセンスの確認

    + `同意して実行する`をクリックする。

6. インストールオプション

    + `カスタム (詳細)`を選択し、`次へ`をクリックする。

7. カスタムインストールオプション（コンポーネントの選択）

    + デフォルトのままで`次へ`をクリックする。

    **※ 複数バージョンの CUDA Toolkit をインストールする場合**

    + `古いバージョン`の CUDA Toolkit をインストールするときは`CUDAだけ`を選択する。（`CUDA`以外のコンポーネントはチェックを外す）

8. インストール場所を選択

    + デフォルトのままで`次へ`を選択する。

9. インストール

    + このとき、Windows セキュリティの画面が開いたときは`インストール`をクリックする。

    **※ インストールが失敗した場合**

    + 失敗したときは、もう一度インストーラを起動し、インストールするコンポーネントを必要なものに絞ってインストールする。

10. Nsight Visual Studio

    + Visual Studio がインストール済みのときは、`Nsight for Vusual Studio`がインストールされたことが確認できる。

11. インストール終了の確認

    + `閉じる`をクリックする。（ショートカットの作成などは任意）

    **※ 再起動が必要な場合は再起動する。**

    + GeForce Experienceが開いた場合

    + `同意 / 実行`をクリックする。
    + リリースハイライトは`×`
    + `GPU向けの新しいドライバーが入手可能`と表示された場合は、新しいドライバをインストールする。

13. 環境変数が設定されていることを確認

    + システム環境変数 PATH

      ```
      C:\Program Files\NVIDA GPU Computing Toolkit\CUDA\v10.0\bin
      C:\Program Files\NVIDA GPU Computing Toolkit\CUDA\v10.0\libnvvp
      ```

      **※ 複数バージョンのCUDAをインストールする場合**

      + 新しいバージョンの環境変数が上にくるように調整する。

    + システム環境変数 CUDA_PATH

      ```
      C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v10.0
      ```
    
      **※ 複数バージョンの CUDA Toolkit をインストールしている場合は、最後にインストールしたものが設定される。**

    + システム環境変数 CUDA_PATH_V10_0

      ```
      C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v10.0
      ```

14. `nvcc`にパスが通っていることを確認

    + コマンドプロンプトで以下を実行する。

    ```
    where nvcc
    ```

<br>

<br>

## cuDNN セットアップ

1. <a href="https://developer.nvidia.com/rdp/form/cudnn-download-survey" target="_blank">cuDNN - Download</a> へアクセス

2. `Join`を選択し、NVIDIA Developer のチームに入る（アカウントは各自作成する / Googleなどからログインする）

3. `I Agree To the Teams ...`のチェックボックスをクリック

4. `Download cuDNN v7.6.1 (June 24, 2019) for CUDA 10.0`をクリック

5. `cuDNN Library for Windows 10`をクリックし、zipファイルをダウンロード

6. ダウンロードしたファイルを展開

7. 展開したフォルダ内の`bin` / `include` / `lib`フォルダを`C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v10.0`に移動（binフォルダのファイルはbinフォルダに移動）

<br>

<br>

## OpenCV セットアップ

1. <a href="https://opencv.org/releases/" target="_blank">OpenCV - Releases</a> からバージョン`3.4.6`の`Windows`をダウンロード（3.4.6でなくても3.x.xならOK）

2. インストーラを起動

3. インストール先を指定

   + `C:\`などどこでも良い。
   + `C:\opencv`というフォルダができる。
     + このとき、フォルダ名を`opencv_346`などのようにバージョンが分かるようにリネームしておくほうが良い。

4. 環境変数の設定

   + `コントロールパネル` > `システムとセキュリティ` > `システム` > `システムの詳細設定` > `環境変数` > `システム環境変数` > `Path` > `編集` > `新規`

   + ```
     C:\opencv_346\build\x64\vc15\bin
     ```

     を設定する。

<br>

<br>

## Darknet

1. <a href="https://github.com/alexeyAB/darknet.git" target="_blank">https://github.com/alexeyAB/darknet.git</a> を Clone または zip をダウンロード（zip をダウンロードした場合は、展開までする）

2. `darknet\build\darknet`に移動

3. `darknet.sln`を起動（VS 2017）

   + ソリューション操作の再ターゲットが出た場合は、`OK`をクリック

4. ソリューション（darknet）を右クリック > `プロジェクトの再ターゲット` > `OKを選択`

   ![1561472100160](https://github.com/kazuya0202/setup-darknet/blob/master/images/1561472100160.png)

5. 同様にソリューションを右クリック、`プロパティ`をクリック

   + インクルードディレクトリの設定

     1. `C/C++` > `全般` > `追加のインクルードディレクトリ` > `▼` > `編集` をクリックする。

        ![1561472386937](https://github.com/kazuya0202/setup-darknet/blob/master/images/1561472386937.png)

     2. `新しい行`をクリックし、以下を設定する。

        ```
        C:\opencv_346\build\include
        ```
     
        ![1561472503506](https://github.com/kazuya0202/setup-darknet/blob/master/images/1561472503506.png)

   + リンカーの追加ライブラリディレクトリの設定

     1. `リンカー` > `追加のライブラリディレクトリ` > `▼` > `編集`をクリックする。

        ![1561473145522](https://github.com/kazuya0202/setup-darknet/blob/master/images/1561473145522.png)

     2. `新しい行`をクリックし、以下を設定する。

        ```
        C:\opencv_346\build\x64\vc15\lib
        ```
   
        ![1561473268096](https://github.com/kazuya0202/setup-darknet/blob/master/images/1561473268096.png)

   + ビルドの依存関係の設定
   
     1. ソリューションを右クリック > `ビルドの依存関係` > `ビルドのカスタマイズ`

        ![1561473401067](https://github.com/kazuya0202/setup-darknet/blob/master/images/1561473401067.png)

     2. すでについているチェックを外し、`CUDA 10.0`を選択して`OK`をクリック

        ![1561473576079](https://github.com/kazuya0202/setup-darknet/blob/master/images/1561473576079.png)

6. ビルド設定

   + ビルドを`Release` / `x64`にする

   ![1561473703555](https://github.com/kazuya0202/setup-darknet/blob/master/images/1561473703555.png)

7. 一度ビルドする

   + `Ctrl + Shift + B` （`メニューバー` > `ビルド` > `ソリューションのビルド`）

   **※ このとき、OpenCV の設定がうまくいかずエラーが発生する（はず）**

   + その場合、`インクルードディレクトリ` / `追加のライブラリディレクトリ`と同じようにもう一度設定するが、一度ビルドした後に、インクルードディレクトリの編集画面に行くと下のようにいくつかのパスが指定されている。

   + その中で2行目の`C:\opencv_3.0\...`を自分の環境での OpenCV のパスに変更する。

      ```
      C:\opencv_346\build\include
      ```
   
     ![1561474407859](https://github.com/kazuya0202/setup-darknet/blob/master/images/1561474407859.png)

   + `追加のライブラリディレクトリ`も同様に、3行目を自分の環境のパスに変更する。

      ```
      C:\opencv_346\build\x64/vc14\lib
      ```

     ![1561474360504](https://github.com/kazuya0202/setup-darknet/blob/master/images/1561474360504.png)
   
8. 再度ソリューションをビルド

   + （成功するはず）
   + 成功した場合は、`darknet/build/darknet/x64/`フォルダの中に`darknet.exe`ができている

   ※ 成功しない場合は、手順をやり直す

   + Visual Studioの関係でエラーが出ている可能性もあるかも

9. ビルドが正常にできたのか検証

   2. 下記のコマンドを実行

      ```bash
      # dir: ~\darknet\build\darknet\x64\
      .\darknet.exe
      ```
      
      > RESULT:
      >
      > ```bash
      > usage: .\darknet <function>
      > ```
   
      上の結果が得られれば、正常にビルドされている。



