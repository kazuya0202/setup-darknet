# Set Up Darknet-Environment(Linux)

*Description* :  `https://github.com/kazuya0202/setup-darknet.git`

| Install Package | Version |
| :-------------: | :-----: |
|  NVIDIA Driver  |    -    |
|     OpenCV      |  3.3.0  |
|      CUDA       |  10.0   |
|      cuDNN      |  8.0 ?  |



#### Table of contents

+ [0. Prepare For Install](#0.-prepare-for-install)
+ [1. Set Up OpenCV](#1.-set-up-opencv)
+ [2. Set Up CUDA](#2.-set-up-cuda)
+ [3. Set Up cuDNN](#3.-set-up-cudnn)
+ [4. Build Darknet](#4.-build-darknet)



### 0. Prepare For Install

*Packages* : 

+ apt-fast ...
+ NVIDIA Driver



> #### <u>< 重要 ></u>
>
> - ##### 実行する前にCUIに切り替えること！
>
>   ```bash
>   $ sudo systemctl set-default multi-user.target
>   $ sudo reboot
>   ```
>
> 
>
> - Virtual Boxで試したときは、CUIに切り替えると`デスクトップ`が`◆◆◆◆◆◆`に文字化けしていたため、あらかじめ`Desktop`などと英語に変えておくとよい ▼
>
> > #####  初期フォルダ名の変換スクリプト
> >
> > ```bash
> > $ bash ./scripts/rename-home-directory.sh
> > ```
> >
> > ウィンドウが出てきたら`Update names`を選択する
>
> 
>
> - GUIに戻すときは
>
>   ```bash
>   $ sudo systemctl set-default graphical.target
>   $ sudo reboot
>   ```
>
>   で切り替えることができる



*Run Script*

```bash
$ bash ./prepare.sh
```

> A. Install Basic (or useful) Command
>
> ```bash
> $ apt install -y sudo curl wget
> 
> $ /bin/bash -c "$(curl -sL https://git.io/vokNn)"
> 
> $ apt-fast install -y build-essential software-properties-common byobu git htop man unzip vim cmake
> ```
>
> B. Set Up NVIDIA Driver
>
> ```bash
> $ apt-fast install -y nvidia-340 libnvidia-cfg1-390 libnvidia-common-390 libnvidia-computee-390 libnvidia-decode-390 libnvidia-encode-390 libnvidia-fbc1-390 libnvidia-gl-390 libnvidia-ifr1-390 nvidia-dkms-390 nvidia-driver390 nvidia-kernel-common-390 nvidia-kernel-source-390 nvidia-modprobe nvidia-opencl-dev nvidia-settings nvidia-utils-390 xserver-xorg-video-nvidia-390
> ```
>





### 1. Set Up OpenCV

*Description* :

​	Install 3.3.0 version of OpenCV



*Run Script*

```bash
$ bash ./install-opencv.sh
```

> 途中にLocation, Time Zoneを答えないと一向に進まないため注意する  
>
> Location => Tokyo  
>
> Time Zone => Asia  





### 2. Set Up CUDA

*Description* :

​	Install 10.0 version of CUDA



*Run Script*

```bash
$ bash　./install-cuda.sh
```

> スクリプト終了後1度再起動すること
>
> ```bash
> $ sudo reboot
> ```



**Check if installed**

```bash
$ nvcc --version
```

> **Result Example** : 
>
> ```
> nvcc: NVIDIA (R) Cuda compiler driver
> Copyright (c) 2005-2018 NVIDIA Corporation
> Built on Sat_Aug_25_21:08:01_CDT_2018
> Cuda compilation tools, release 10.0, V10.0.130
> ```





### 3. Set Up cuDNN

*Description* : 

+ install cudnn of 8.0.0 version

> ※ https://developer.nvidia.com/rdp/cudnn-download にログインしておくこと



*Run Script*

```bash
$ bash ./install-cudnn.sh
```



**confirm**

```bash
$ cat ? ls ?
```

> **Result Example** : 
>
> 





### 4. Build Darknet

*Description* : 

+ clone repository : `https://github.com/alexeyAB/darknet.git`
+ clone repository : `https://github.com/kazuya0202/Makefile-for-darkent.git`
+ edit `Makefile`



*Run Script*

```bash
$ bash ./install-darknet.sh
```





### 5. Set Up Learning Environment

*Description* : follow the repository : `https://github.com/alexeyAB/darknet.git`

1. 学習にひつような設定ファイル・画像ファイルなどをまとめるディレクトリを作成する

   ```bash
   # directory : /home/{USER_NAME}/darknet
   $ mkdir -p task/backup/
   ```

   

2. `yolov3.cfg`をコピーして`yolo-obj.cfg`ファイルを作る

   ```bash
   # directory : /home/{USER_NAME}/darknet/cfg
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
     >   **Example** :
     >
     >   ```bash
     >   classes=1 ---> filters=18
     >   classes=2 ---> filters=21
     >   ```

3. `obj.names`を作成する

   + ```bash
     # directory : /home/{USER_NAME}/darknet/task
     $ touch obj.names
     $ vim obj.names
     ```

     > オブジェクトの名前を一行ごとに記述する（クラス数分）
     >
     >  **Example** :
     >
     > ```bash
     > Railroad crossing	# 踏切
     > Car					# 車
     > ```

4. `obj.data`を作成する

   + ```bash
     # directory : /home/{USER_NAME}/darknet/task
     $ touch obj.data
     $ vim obj.data
     ```

     > 書式は以下のようにする
     >
     > **Example** :
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
     > > $ bash ./rename-seq.sh
     > > ```
     >
     > 

6. 画像ファイル・テキストファイルを`datasets`の中に入れる

   + ```bash
     # directory : /home/{USER_NAME}/darknet/task
     $ mkdir datasets
     $ mv {path}/car**.jpg datasets/
     $ mv {path}/car**.txt datasets/
     ```

7.