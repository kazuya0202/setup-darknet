# Set Up Darknet-Environment(Linux)

###### *Description* :  

```http
# github
https://github.com/kazuya0202/setup-darknet.git
```



| Install Package | Version |
| :-------------: | :-----: |
|  NVIDIA Driver  |    -    |
|     OpenCV      |  3.3.0  |
|      CUDA       |  10.0   |
|      cuDNN      |  7.6.0  |

  

# め～も～

```bash
## cmake of OpenCV ( CUDAをインストールした後で )

# CUDA=OFF にして cmake
$ cmake /* ... */ -D WITH_CUDA=OFF ..

```



#### もくじ

+ [0. Prepare For Install](#0.-prepare-for-install)
+ [1. Set Up OpenCV](#1.-set-up-opencv)
+ [2. Set Up CUDA](#2.-set-up-cuda)
+ [3. Set Up cuDNN](#3.-set-up-cudnn)
+ [4. Build Darknet](#4.-build-darknet)  



### 0. 環境構築の前に必要なものをインストールする

###### *Packages* : 

+ apt-fast / cmake / build-essential ...



###### *Run Script*

```bash
$ sudo apt install -y git
$ git clone https://github.com/kazuya0202/setup-darknet-linux.git

$ bash ./prepare.sh
```





##  < 重要 >

#### 	〇 <u>CUIにして実行すること</u>



> + Virtual Boxで試したときは、CUIに切り替えると日本語がに文字化けするため、あらかじめフォルダ名を英語に変えておくとよい ▼
>
> ##### 初期フォルダ名の変換スクリプト
>
> ```bash
> $ bash ./scripts/rename-home-directory.sh
> ```
>
> ウィンドウが出てきたら`Update names`を選択する  
>
> 
>
> ##### フォルダ名を日本語に戻したい場合
>
> ```bash
> $ xdg-user-dirs-gtk-update
> ```
>
> ウィンドウが出てきたら`選択する`を選択する
>
> 
>
> - ところどころ日本語表示が文字化けするため、言語を英語に変えておけば文字化けしない（変更後は再起動）
>
> ###### 言語を英語に変更
>
> ```bash
> $ bash ./scripts/change-locale-en.sh
> ```
>
> 
>
> ###### 言語を日本語に変換
>
> ```bash
> $ bash ./scripts/change-locale-ja.sh
> ```



##### CUIに切り替える

```bash
$ sudo systemctl set-default multi-user.target
$ sudo reboot
```



> ######  GUIに戻したい場合
>
> ```bash
> $ sudo systemctl set-default graphical.target
> $ sudo reboot
> ```





### 1. CUDAのセットアップ

###### *Description* :

​	バージョン：10.0



###### *Run Script*

```bash
$ bash　./install-cuda.sh
```

> ##### スクリプト終了後1度再起動すること
>
> ```bash
> $ sudo reboot
> ```

  

##### インストールされているかどうかの確認

```bash
$ nvcc --version
```

> ##### Result Exmple : 
>
> ```
> nvcc: NVIDIA (R) Cuda compiler driver
> Copyright (c) 2005-2018 NVIDIA Corporation
> Built on Sat_Aug_25_21:08:01_CDT_2018
> Cuda compilation tools, release 10.0, V10.0.130
> ```
>
> もし、`bash: nvcc: command not found`が出力された場合は、`.　~/.bashrc`でスクリプトを読み込ませてからもう一度実行する





### 2. cuDNNのセットアップ

###### *Description* : 

​	バージョン：7.6.0



> 1. ###### ブラウザから`.deb`をダウンロードする場合
>
>    1. https://developer.nvidia.com/rdp/cudnn-download をブラウザで開いてログインする（必要に応じてアカウントを作る・Googleなどと連携する）
>
>    2. ```
>       cuDNN Library for Linux
>       
>       cuDNN Runtime Library for Ubuntu18.04 [Deb]
>       cuDNN Developer Library for Ubuntu18.04 [Deb]
>       cuDNN Code Samples and User Guide for Ubuntu18.04 [Deb]
>       ```
>
>    上記の3ファイルをダウンロードする
>
>    
>
> 2. ###### gitリポジトリを落とす場合
>
>    1. ```bash
>       $ git clone https://gitlab.com/ichiya/setup-cudnn.git
>       ```





```bash
# bash にかくやつ
sudo mv ~/Downloads/libcudnn*.deb ./
sudo mv ~/Downloads/cudnn-*.tgz ./

sudo dpkg -i libcudnn7_7.3.0.29–1+cuda10.0_amd64.deb
sudo dpkg -i libcudnn7-dev_7.3.0.29–1+cuda10.0_amd64.deb
sudo dpkg -i libcudnn7-doc_7.3.0.29–1+cuda10.0_amd64.deb

tar -xzvf cudnn-10.0-linux-x64-v7.6.0.64.tgz

sudo cp -a cuda/lib64/* /usr/local/cuda/lib64/
sudo cp -a cuda/include/* /usr/local/cuda/include/

cp -r /usr/src/cudnn_samples_v7/ ~/
cd ~/cudnn_samples_v7/mnistCUDNN/
make clean && make

# occured error => c/c++ 6
sudo apt install gcc-6 g++-6

sudo ln -s /usr/bin/gcc-6 /usr/local/cuda/bin/gcc
sudo ln -s /usr/bin/g++-6 /usr/local/cuda/bin/g++

cd ~/cudnn_samples_v7/mnistCUDNN
make clean && make
./mnistCUDNN
```



###### *Run Script*

```bash
$ bash ./install-cudnn.sh
```



##### インストールされているかどうかの確認

```bash
$ cat /usr/local/cuda/include/cudnn.h | grep CUDNN_MAJOR -A 2
```

> ##### Result Exmple : 
>
> ```
> #define CUDNN_MAJOR 7
> #define CUDNN_MINOR 6
> #define CUDNN_PATCHLEVEL 0
> --
> #define CUDNN_VERSION (CUDNN_MAJOR * 1000 + CUDNN_MINOR * 100 + CUDNN_PATCHLEVEL)
> 
> #include "driver_types.h"
> ```
>
> 上の場合だとバージョンは`7.6.0`





### 3. OpenCVのセットアップ

###### *Description* :

​	バージョン：3.3.0



###### *Run Script*

```bash
$ bash ./install-opencv.sh
```

> 途中に`Location` , `Time Zone`を答えないと一向に進まないため注意する  





### 4. Darknetのビルド

###### *Description* : 

+ リポジトリのクローン

  ```http
  # github
  https://github.com/alexeyAB/darknet.git
  https://github.com/kazuya0202/Makefile-for-darkent.git
  ```

+ `Makefile`を編集する

  + `GPU` / `CUDNN` / `OPENCV`を有効にする



###### *Run Script*

```bash
$ bash ./install-darknet.sh
```





### 5. 学習環境のセットアップ

###### *Description* :

```http
# 以下のREADMEに従う
https://github.com/alexeyAB/darknet.git
```

+ `dir: XXX`は現在のディレクトリを表す



1. 学習にひつような設定ファイル・画像ファイルなどをまとめるディレクトリを作成する

   ```bash
   # dir : /home/{USER_NAME}/darknet
   $ mkdir -p task/backup/
   ```

   

2. `yolov3.cfg`をコピーして`yolo-obj.cfg`ファイルを作る

   ```bash
   # dir : /home/{USER_NAME}/darknet/cfg
   $ cp yolov3.cfg yolo-obj.cfg
   $ mv yolo-obj.cfg ../task/
   ```

   + `yolo-obj.cfg`の数値を変更する

     ```bash
     batch=64
     subdivisions=8
     max_batches=2000	# classes*2000
     steps=1600,1800		# max_batches*0.80, max_batches*0.90
     # ...... 
     
     
     ## 以下3か所ずつ（filtersはたくさんあるため、classesで検索をかけて見つけること）
     
     ## filters: 603行目, 696行目, 783行目
     ## classes: 610行目, 687行目, 767行目 (2019/6/16 現在)
     ## （クラス数が2の場合）
     
     # [convolutional]
     filters=21	# classesの上にあるfiltersの数値だけ変更
     
     # [yolo]
     classes=2
     ```

     > + 学習を開始したときに、GPUのメモリの関係でエラーが発生して中断したときは`subdivision`の値を変更すること
     >
     >   ```bash
     >   subdivision=16	# next to 8
     >   subdivision=32	# next to 16
     >   subdivision=64	# next to 32
     >   ```
     >
     >   
     >
     > + `filters`の数値は以下の式で計算する
     >
     >   ```bash
     >   (classes + 5) * 3
     >   ```
     >
     >   ##### Example :
     >
     >   ```bash
     >   classes=1 ---> filters=18
     >   classes=2 ---> filters=21
     >   ```
     
     

3. `obj.names`を作成する

   + ```bash
     # dir : /home/{USER_NAME}/darknet/task
     $ touch obj.names
     $ vim obj.names
     ```

     > オブジェクトの名前を一行ごとに記述する（クラス数分）
     >
     >  ##### Example :
     >
     > ```bash
     > Railroad crossing	# 踏切
     > Car					# 車
     > ```
     
     

4. `obj.data`を作成する

   + ```bash
     # dir : /home/{USER_NAME}/darknet/task
     $ touch obj.data
     $ vim obj.data
     ```

     > 書式は以下のようにする
     >
     > ##### Example :
     >
     > ```
     > classes = 2
     > train   = task/train.txt
     > valid   = task/test.txt
     > names   = task/obj.names
     > backup  = task/backup/
     > ```
     
     

5. 画像のラベル付けする

   - [BBox-Label-Tool](https://github.com/puzzledqs/BBox-Label-Tool)を使う（使い方はREADME参照）

     - [Yolo_mark](https://github.com/AlexeyAB/Yolo_mark)つかってもいけるはず（OpenCV必須）

     > セットアップは以下のコマンド（python3で動作）
     >
     > ```bash
     > $ bash ./clone-blt.sh
     > ```
     >
     > 
     >
     > > 画像ファイルを`.jpg`に統一 & ファイル名を連番にする
     > >
     > > ```bash
     > > $ bash ./jpg-rename.sh
     > > ```
     > >
     > > エラーのようにメッセージが出力されるが実行できているため気にする必要はない
     >
     
     

6. 画像ファイル・テキストファイルを`datasets`の中に入れる

   + ```bash
     # dir : /home/{USER_NAME}/darknet/task
     $ mkdir datasets
     $ mv {path}/car**.jpg datasets/
     $ mv {path}/car**.txt datasets/
     ```
     
     

7.